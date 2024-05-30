import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';
import 'package:logger/logger.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc(this._transactionsRepository)
      : _logger = Logger(),
        super(const StatsState()) {
    on<StatsInitialEvent>(_subscribeToExpenseData);
    on<LoadIncomeDataEvent>(_subscribeToIncomeData);
    on<DisplayIncomePieChartStats>(_displayIncomePieChart);
    on<DisplayExpensePieChartStats>(_displayExpensePieChart);
  }

  final TransactionsRepository  _transactionsRepository;
  final Logger _logger;

  List<TransactionCategory> calculateCategories(
    List<Transaction> transaction,
  ) {
    final transactionCategories = <TransactionCategory>[];
    for (final element in transaction) {
      // _logger.d(element.category.name);
      ///Todo I'm using Isar LInks here, so I have to figure out how here.
      // transactionCategories.add(element.transactionCategory);
    }
    return transactionCategories.toSet().toList();
    _logger.d('This is a set of all of the categories $transactionCategories');
  }

// Future<List<Expense>> getAllExpenses()async{
//
// }
  Future<StatsState> _subscribeToExpenseData(
    StatsInitialEvent event,
    Emitter<StatsState> emit,
  ) async {
    await emit.forEach<List<PieChartDataObject>>(
      _transactionsRepository.getTransactionsByCategory(),
      onData: (expenseCategoryTotals) {
        // _logger.d('These are the category totals  : $categoryTotals');
        return state.copyWith(
          status: () => StatsStatus.success,
          // monthlyExpenses: () => expense.reversed.toList(),
          expenseCategoryTotals: () => expenseCategoryTotals,
        );
      },
    );
    return state.copyWith(
      expenseCategoryTotals: () => [],
    );
  }

  Future<StatsState> _subscribeToIncomeData(
    LoadIncomeDataEvent event,
    Emitter<StatsState> emit,
  ) async {
    await emit.forEach<List<PieChartDataObject>>(
      _transactionsRepository.getIncomeByCategory(),
      onData: (incomeCategoryTotals) {
        // _logger.d('These are the category totals  : $categoryTotals');
        return state.copyWith(
          status: () => StatsStatus.success,
          // monthlyExpenses: () => expense.reversed.toList(),
          incomeCategoryTotals: () => incomeCategoryTotals,
        );
      },
    );
    return state.copyWith(
      incomeCategoryTotals: () => [],
    );
  }

  FutureOr<void> _displayIncomePieChart(
    DisplayIncomePieChartStats event,
    Emitter<StatsState> emit,
  ) {
    emit(state.copyWith(
      showTransactions: () =>  false,
      status: () => StatsStatus.success,
    ),);
    _logger
      ..d('display Income Pie chart should be true')
      ..d('${state.showExpenses}');
  }

  FutureOr<void> _displayExpensePieChart(
    DisplayExpensePieChartStats event,
    Emitter<StatsState> emit,
  ) {
    {
      emit(state.copyWith(
        showTransactions: () => true,
        status: () => StatsStatus.success,
      ),);
    }
  }
}

// final sortedCategories =  calculateCategories(state.monthlyExpenses);
// final expensesPerCat = expensePerCategory( state.monthlyExpenses);
// _logger..d('These are the expenses per category $expensesPerCat')
// ..d('These are the sorted categories $sortedCategories');
