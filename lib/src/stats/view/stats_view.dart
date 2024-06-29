import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:razor_expense_tracker_new/src/stats/bloc/stats_bloc.dart';
import 'package:transactions_repository/transactions_repository.dart';

import '../../widgets/konstants.dart';

class StatsOverviewPage extends StatelessWidget {
  const StatsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => StatsBloc(
              context.read<TransactionsRepository>(),
            )
              ..add(const SubscribeToTransactionsEvent())
              ..add(SubscribeToCategoriesEvent()),
        child: StatsView());

    // );
  }
}

class emptyStatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No data to display'),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          switch (state.status) {
            case StatsStatus.success:
              return StatsSuccessView();

            case StatsStatus.loading:
              return const Center(
                child: Text('Loading'),
              );
            case StatsStatus.initial:
              return const Center(
                child: Text('Initial'),
              );

            case StatsStatus.failure:
              return Center(
                child: emptyStatsView(),
              );
          }
        },
      ),
    );
  }
}

class StatsSuccessView extends StatelessWidget {
  StatsSuccessView({super.key}) : _logger = Logger();
  final Logger _logger;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatsBloc, StatsState>(
      listenWhen: (previous, current) =>
          previous.datePeriodChosen != current.datePeriodChosen,
      listener: (context, state) {
        context.read<StatsBloc>()
          ..add(SubscribeToTransactionsEvent())
          ..add(SubscribeToCategoriesEvent());
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Analytics',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                )),
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<StatsBloc>().add(ExpenseDisplayRequested());
                    },
                    child: const Text(
                      'Expenses',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StatsBloc>().add(IncomeDisplayRequested());
                    },
                    child: const Text(
                      'Income',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InputChip(
                      label: Text('All Time'),
                      onPressed: () {
                        context.read<StatsBloc>().add(
                            DatePeriodChosenEvent(DatePeriodChosen.allTime));
                      },
                      selectedColor: Colors.yellow,
                      selected:
                          state.datePeriodChosen == DatePeriodChosen.allTime,
                    ),
                    InputChip(
                      label: Text(' Yearly'),
                      onPressed: () {
                        context.read<StatsBloc>().add(
                            DatePeriodChosenEvent(DatePeriodChosen.yearly));
                      },
                      selectedColor: Colors.yellow,
                      selected:
                          state.datePeriodChosen == DatePeriodChosen.yearly,
                    ),
                    InputChip(
                      label: Text('Monthly'),
                      onPressed: () {
                        context.read<StatsBloc>().add(
                            DatePeriodChosenEvent(DatePeriodChosen.monthly));
                      },
                      selectedColor: Colors.yellow,
                      selected:
                          state.datePeriodChosen == DatePeriodChosen.monthly,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text('2024'),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text('January'),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.5,
                child: Column(children: [
                  // state.isDisplayExpenses
                  //     ? Text(state.totalAmount.toStringAsFixed(1))
                  //     : Text('Income Goes here'),
                  Expanded(
                    child: PieChart(

                      PieChartData(
                        centerSpaceColor: Colors.green,
                        sections: List.generate(
                          state.sortedCategories.length,
                          (index) {
                            return PieChartSectionData(
                                radius: 70,
                                color: colorMapper[
                                    state.sortedCategories[index].colorName],
                                titleStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                value: state.isDisplayExpenses
                                    ? state.sortedCategories[index]
                                        .totalExpenseAmount
                                        .toDouble()
                                    : state.sortedCategories[index]
                                        .totalIncomeAmount
                                        .toDouble(),
                                title: state.isDisplayExpenses
                                    ? '${state.sortedCategories[index].name}\n'
                                        '\$${state.sortedCategories[index].totalExpenseAmount}'
                                    : '${state.sortedCategories[index].name}\n'
                                        '\$${state.sortedCategories[index].totalIncomeAmount}');
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    if (state.isDisplayExpenses &&
                        state.categories[index].totalExpenseAmount > 0) {
                      return InputChip(
                        onPressed: () {},
                        label: Text(
                            style: TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.visible,
                            ),
                            '${state.categories[index].name} '
                            ' ${state.categories[index].expensePercentage} %'),
                        //
                        backgroundColor:
                            colorMapper[state.categories[index].colorName],
                      );
                    } else if (state.isDisplayIncome &&
                        state.categories[index].totalIncomeAmount > 0) {
                      return InputChip(
                        onPressed: () {},
                        label: Text(
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              overflow: TextOverflow.visible,
                            ),
                            '${state.categories[index].name} '
                            ' ${state.categories[index].incomePercentage} %'),
                        //
                        backgroundColor:
                            colorMapper[state.categories[index].colorName],
                      );
                    } else {
                      return Container();
                    }
                    //
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 5)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
