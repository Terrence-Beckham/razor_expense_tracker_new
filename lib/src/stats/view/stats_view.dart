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
    return MultiBlocListener(
        listeners: [
          BlocListener<StatsBloc, StatsState>(
            listenWhen: (previous, current) =>
                previous.datePeriodChosen != current.datePeriodChosen,
            listener: (context, state) {
              context.read<StatsBloc>()..add(SubscribeToTransactionsEvent());
            },
          ),
          BlocListener<StatsBloc, StatsState>(
            listenWhen: (previous, current) =>
                previous.selectedMonth != current.selectedMonth,
            listener: (context, state) {
              context.read<StatsBloc>()..add(SubscribeToTransactionsEvent());
            },
          ),
          BlocListener<StatsBloc, StatsState>(
            listenWhen: (previous, current) =>
                previous.selectedYear != current.selectedYear,
            listener: (context, state) {
              context.read<StatsBloc>()..add(SubscribeToTransactionsEvent());
            },
          ),
          BlocListener<StatsBloc, StatsState>(
            listenWhen: (previous, current) =>
                previous.incomeTransactionTotals !=
                current.incomeTransactionTotals,
            listener: (context, state) {
              context.read<StatsBloc>()..add(SubscribeToTransactionsEvent());
            },
          ),
          BlocListener<StatsBloc, StatsState>(
            listenWhen: (previous, current) =>
                previous.expenseTransactionTotals !=
                current.expenseTransactionTotals,
            listener: (context, state) {
              context.read<StatsBloc>()..add(SubscribeToTransactionsEvent());
            },
          ),
        ],
        child: BlocBuilder<StatsBloc, StatsState>(
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
                          context
                              .read<StatsBloc>()
                              .add(ExpenseDisplayRequested());
                        },
                        child: const Text(
                          'Expenses',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<StatsBloc>()
                              .add(IncomeDisplayRequested());
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
                            context.read<StatsBloc>().add(DatePeriodChosenEvent(
                                DatePeriodChosen.allTime));
                          },
                          selectedColor: Colors.green,
                          selected: state.datePeriodChosen ==
                              DatePeriodChosen.allTime,
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
                            context.read<StatsBloc>().add(DatePeriodChosenEvent(
                                DatePeriodChosen.monthly));
                          },
                          selectedColor: Colors.red,
                          selected: state.datePeriodChosen ==
                              DatePeriodChosen.monthly,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                        ),
                        switch (state.datePeriodChosen) {
                          DatePeriodChosen.allTime => Container(),
                          DatePeriodChosen.yearly => YearDropdownMenu(),
                          DatePeriodChosen.monthly => Row(
                              children: [
                                YearDropdownMenu(),
                                SizedBox(width: 25),
                                DateDropdownMenu(),
                              ],
                            )
                        },
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 1.5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        state.isDisplayExpenses &&
                                state.expenseTransactionTotals >0
                            ? Text(
                                'Expenses\n' +
                                    r'$ ' +
                                    state.expenseTransactionTotals
                                        .toStringAsFixed(1),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            : Text(''),
                        state.isDisplayIncome &&
                                state.incomeTransactionTotals >0
                            ? Text(
                                'Income\n' +
                                    r'$ ' +
                                    state.incomeTransactionTotals
                                        .toStringAsFixed(1),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            : Text(''),
                        state.sortedCategories.isNotEmpty
                            ? PieChart(
                                PieChartData(
                                  titleSunbeamLayout: true,
                                  sections: List.generate(
                                    state.sortedCategories.length,
                                    (index) {
                                      return PieChartSectionData(
                                          radius: 50,
                                          color: colorMapper[state
                                              .sortedCategories[index]
                                              .colorName],
                                          titleStyle: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          value: state.isDisplayExpenses
                                              ? state.sortedCategories[index]
                                                  .totalExpenseAmount
                                                  .toDouble()
                                              : state.sortedCategories[index]
                                                  .totalIncomeAmount
                                                  .toDouble());
                                      // title: state.isDisplayExpenses
                                      //     // ? '${state.sortedCategories[index].name}\n'
                                      //     ? '\$${state.sortedCategories[index].totalExpenseAmount}'
                                      //     // : '${state.sortedCategories[index].name}\n'
                                      //     : '\$${state.sortedCategories[index].totalIncomeAmount}');
                                    },
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  'There is no Data for this period',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    // Variable to store the total
                    // Iterating over the list using a for loop
                    //              for (double amount in amounts) {
                    //    total += amount;
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.sortedCategories.length,
                      itemBuilder: (context, index) {
                        if (state.isDisplayExpenses &&
                            state.sortedCategories[index].totalExpenseAmount >
                                0) {
                          return InputChip(
                            onPressed: () {},
                            label: Text(
                                style: TextStyle(
                                  color: Colors.white,
                                  overflow: TextOverflow.visible,
                                ),
                                '${state.sortedCategories[index].name} '
                                ' ${(state.expenseTransactionTotals / state.sortedCategories[index].totalExpenseAmount).toPrecision(1)}%'),

                            //
                            backgroundColor: colorMapper[
                                state.sortedCategories[index].colorName],
                          );
                        }
                        if (state.isDisplayIncome &&
                            state.sortedCategories[index].totalIncomeAmount >
                                0) {
                          return InputChip(
                            onPressed: () {},
                            label: Text(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  overflow: TextOverflow.visible,
                                ),
                                '${state.sortedCategories[index].name} '
                                ' ${(state.incomeTransactionTotals / state.sortedCategories[index].totalIncomeAmount).toPrecision(1)}%'),
                            //
                            backgroundColor: colorMapper[
                                state.sortedCategories[index].colorName],
                          );
                        }
                        return Container();

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
        ));
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

//colorMapper = <String, Color>{
//   'red': Colors.red,
//   'yellow': Colors.yellow,
//   'blue': Colors.blue,
//   'white': Colors.white,
class DateDropdownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: DropdownButton<DateLabel>(
            value: state.selectedMonth, // Set the initial selection
            onChanged: (DateLabel? newValue) {
              // Handle the selected value here
              context.read<StatsBloc>().add(SelectedMonthChanged(newValue!));
            },
            items: DateLabel.values
                .map<DropdownMenuItem<DateLabel>>((DateLabel dateLabel) {
              return DropdownMenuItem<DateLabel>(
                value: dateLabel,
                child: Text('${dateLabel.label} '),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class YearDropdownMenu extends StatelessWidget {
  final List<int> years =
      List<int>.generate(10, (int index) => (DateTime.now().year - 2) + index);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: DropdownButton<int>(
            hint: Text('Select a year'),
            value: state.selectedYear,
            onChanged: (int? newValue) {
              context.read<StatsBloc>().add(SelectedYearChanged(newValue!));
              // if (newValue != null) {
              //   context.read<StatsBloc>().add(YearSelected(newValue));
              // }
            },
            items: years.map<DropdownMenuItem<int>>((int year) {
              return DropdownMenuItem<int>(
                value: year,
                child: Text(year.toString()),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
