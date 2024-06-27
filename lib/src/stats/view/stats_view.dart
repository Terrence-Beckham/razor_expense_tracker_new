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
            )..add(const SubscribedToCategoryAmountsEvent()),
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
                child: CircularProgressIndicator(),
              );
            case StatsStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case StatsStatus.failure:
              return const Center(
                child: CircularProgressIndicator(),
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
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        _logger.d(
            'These are the category totals in the stats view ${state.selectedTransactionCategories}');
        return Scaffold(
          appBar: AppBar(
            title:  Text('Analytics',
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
                child: Stack(alignment: Alignment.center, children: [
                  state.isDisplayExpenses
                      ? Text(state.totalAmount.toStringAsFixed(1))
                      : Text('Income Goes here'),
                  PieChart(
                    PieChartData(
                      sections: List.generate(
                        state.selectedTransactionCategories.length,
                        (index) {
                          return PieChartSectionData(
                              radius: 70,
                              color: colorMapper[state
                                  .selectedTransactionCategories[index]
                                  .colorName],
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              value: state.isDisplayExpenses
                                  ? state.selectedTransactionCategories[index]
                                      .totalExpenseAmount
                                      .toDouble()
                                  : state.selectedTransactionCategories[index]
                                      .totalIncomeAmount
                                      .toDouble(),
                              title: state.isDisplayExpenses
                                  ? '${state.selectedTransactionCategories[index].name}\n'
                                      '\$${state.selectedTransactionCategories[index].totalExpenseAmount}'
                                  : '${state.selectedTransactionCategories[index].name}\n'
                                      '\$${state.selectedTransactionCategories[index].totalIncomeAmount}');
                        },
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
                  itemCount: state.selectedTransactionCategories.length,
                  itemBuilder: (context, index) {
                    if (state.isDisplayExpenses &&
                        state.selectedTransactionCategories[index]
                                .totalExpenseAmount >
                            0) {
                      return InputChip(
                        onPressed: () {},
                        label: Text(
                            style: TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.visible,
                            ),
                            '${state.selectedTransactionCategories[index].name} '
                            ' ${state.selectedTransactionCategories[index].expensePercentage} %'),
                        //
                        backgroundColor: colorMapper[state
                            .selectedTransactionCategories[index].colorName],
                      );
                    } else if (state.isDisplayIncome &&
                        state.selectedTransactionCategories[index]
                                .totalIncomeAmount >
                            0) {
                      return InputChip(
                        onPressed: () {},
                        label: Text(
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              overflow: TextOverflow.visible,
                            ),
                            '${state.selectedTransactionCategories[index].name} '
                            ' ${state.selectedTransactionCategories[index].incomePercentage} %'),
                        //
                        backgroundColor: colorMapper[state
                            .selectedTransactionCategories[index].colorName],
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
