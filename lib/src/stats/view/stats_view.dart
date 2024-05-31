import 'package:transactions_repository/transactions_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:razor_expense_tracker_new/src/stats/bloc/stats_bloc.dart';

import '../../widgets/konstants.dart';
import '../temp_stats_bloc/temp_stats_bloc.dart';

class StatsOverviewPage extends StatelessWidget {
  const StatsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TempStatsBloc(
        // context.read<TransactionsRepository>(),
      ),child: emptyStatsView(),
          ///Todo readd this code when I figure out how to get the data from the repository
        // ..add(
        //   const StatsInitialEvent(),
        // )
        // ..add(const LoadIncomeDataEvent()),
    );
  }
}
class emptyStatsView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
return Center(child: Text('No data to display'),);
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
        _logger.d('These are the category totals $state.categoryTotals');
        return Scaffold(
          appBar: AppBar(
            title: const Text('Statistics'),
          ),
          body: Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.arrow_left,
                    size: 40,
                  ),
                  Text('May'),
                  Icon(
                    Icons.arrow_right,
                    size: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<StatsBloc>().add(
                            DisplayExpensePieChartStats(),
                          );
                    },
                    child: const Text(
                      'Expenses',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StatsBloc>().add(
                            DisplayIncomePieChartStats(),
                          );
                      _logger.d(state.showExpenses);
                    },
                    child: const Text(
                      'Income',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                child: state.showExpenses
                    ? PieChart(
                        PieChartData(
                          sections: List.generate(
                              state.expenseCategoryTotals.length, (index) {
                            return PieChartSectionData(
                              color: colorMapper[
                                  state.expenseCategoryTotals[index].color],
                              value: 10,
                              title:
                                  '${state.expenseCategoryTotals[index].title}\n'
                                  '${state.expenseCategoryTotals[index].amount}',
                            );
                          }),
                        ),
                      )
                    : PieChart(
                        PieChartData(
                          sections: List.generate(
                              state.incomeCategoryTotals.length, (index) {
                            _logger.e(
                                'This is what should be: ${state.incomeCategoryTotals}');
                            return PieChartSectionData(
                              color: colorMapper[
                                  state.incomeCategoryTotals[index].color],
                              value: 10,
                              title:
                                  '${state.incomeCategoryTotals[index].title}\n'
                                  '${state.incomeCategoryTotals[index].amount}',
                            );
                          }),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
