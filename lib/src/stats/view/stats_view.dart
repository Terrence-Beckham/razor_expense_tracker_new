import 'package:easy_localization/easy_localization.dart';
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
      child: Text(
        context.tr('noDataToDisplay'),
      ),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              title: Text(context.tr('analytics')
                ,style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
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
                      child: Text(
                        context.tr('expenses'),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<StatsBloc>().add(IncomeDisplayRequested());
                      },
                      child: Text(
                        context.tr("income"),
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
                        label: Text(
                          context.tr('allTime'),
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          context.read<StatsBloc>().add(
                              DatePeriodChosenEvent(DatePeriodChosen.allTime));
                        },
                        selectedColor: Colors.green,
                        selected:
                            state.datePeriodChosen == DatePeriodChosen.allTime,
                      ),
                      InputChip(
                        label: Text(context.tr('yearly'),
                            style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          context.read<StatsBloc>().add(
                              DatePeriodChosenEvent(DatePeriodChosen.yearly));
                        },
                        selectedColor: Colors.yellow,
                        selected:
                            state.datePeriodChosen == DatePeriodChosen.yearly,
                      ),
                      InputChip(
                        label: Text(context.tr('monthly'),
                            style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          context.read<StatsBloc>().add(
                              DatePeriodChosenEvent(DatePeriodChosen.monthly));
                        },
                        selectedColor: Colors.red,
                        selected:
                            state.datePeriodChosen == DatePeriodChosen.monthly,
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
                      if (state.datePeriodChosen ==
                          DatePeriodChosen.yearly) ...[
                        YearDropdownMenu()
                      ] else if (state.datePeriodChosen ==
                          DatePeriodChosen.monthly) ...[
                        YearDropdownMenu(),
                        const SizedBox(width: 25),
                        DateDropdownMenu()
                      ]
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 1.5,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (state.isDisplayExpenses &&
                          state.expenseTransactionTotals > 0)
                        Text(
                          context.tr('expenses') +
                              '\n\$ ' +
                              state.expenseTransactionTotals.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize:24 ,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (state.isDisplayIncome &&
                          state.incomeTransactionTotals > 0)
                        Text(
                          context.tr('income') +
                              '\n\$ ' +
                              state.incomeTransactionTotals.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      if (state.sortedCategories.isNotEmpty)
                        PieChart(
                          PieChartData(
                            titleSunbeamLayout: true,
                            sections: List.generate(
                              state.sortedCategories.length,
                              (index) {
                                return PieChartSectionData(
                                    radius: 50,
                                    color: colorMapper[state
                                        .sortedCategories[index].colorName],
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
                      else
                        Center(
                          child: Text(
                            context.tr('noDataToDisplay'),
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: state.sortedCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        // return SizedBox(child: TransactionTile(expense: state.expenses[index]));
                        if (state.isDisplayExpenses &&
                            state.sortedCategories[index].totalExpenseAmount >
                                0) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(8, 8),
                                      blurRadius: 15,
                                      spreadRadius: 1),
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-8, -8),
                                      blurRadius: 15,
                                      spreadRadius: 1)
                                ],
                              ),
                              child: ListTile(
                                leading: Icon(
                                  myIcons[
                                      state.sortedCategories[index].iconName],
                                  color: colorMapper[
                                      state.sortedCategories[index].colorName],
                                ),
                                title: Text(
                                  context.tr(
                                          '${state.sortedCategories[index].name?.toLowerCase()}') ??
                                      ' ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                subtitle: Text(
                                  '\$' +
                                      '' +
                                      state.sortedCategories[index]
                                          .totalExpenseAmount
                                          .toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                trailing: Text(
                                  ' ${(state.expenseTransactionTotals / state.sortedCategories[index].totalExpenseAmount).toPrecision(1)}%',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (state.isDisplayIncome &&
                            state.sortedCategories[index].totalIncomeAmount >
                                0) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(8, 8),
                                      blurRadius: 15,
                                      spreadRadius: 1),
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-8, -8),
                                      blurRadius: 15,
                                      spreadRadius: 1)
                                ],
                              ),
                              child: ListTile(
                                leading: Icon(
                                  myIcons[
                                      state.sortedCategories[index].iconName],
                                  color: colorMapper[
                                      state.sortedCategories[index].colorName],
                                ),
                                title: Text(
                                  context.tr(
                                          '${state.sortedCategories[index].name?.toLowerCase()}') ??
                                      ' ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                subtitle: Text(
                                  '\$' +
                                      '' +
                                      state.sortedCategories[index]
                                          .totalIncomeAmount
                                          .toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                trailing: Text(
                                  // '\$ ${state.sortedCategories[index].incomePercentage}',

                                  ' ${(state.incomeTransactionTotals / state.sortedCategories[index].totalIncomeAmount).toPrecision(1)}%',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                        ;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
