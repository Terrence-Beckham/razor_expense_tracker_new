import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_api/expense_api.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:logger/logger.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc(this._expenseRepository)
      : _logger = Logger(),
        super(const StatsState()) {
    on<StatsInitialEvent>(_subscribeToExpenseData);
    on<LoadIncomeDataEvent>(_subscribeToIncomeData);
    on<DisplayIncomePieChartStats>(_displayIncomePieChart);
    on<DisplayExpensePieChartStats>(_displayExpensePieChart);
  }

  final ExpenseRepository _expenseRepository;
  final Logger _logger;

  List<TransactionCategory> calculateCategories(
    List<Expense> expense,
  ) {
    final transactionCategories = <TransactionCategory>[];
    for (final element in expense) {
      // _logger.d(element.category.name);
      transactionCategories.add(element.category);
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
      _expenseRepository.getExpensesByCategory(),
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
      _expenseRepository.getIncomeByCategory(),
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
      showExpenses: () =>  false,
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
        showExpenses: () => true,
        status: () => StatsStatus.success,
      ),);
    }
  }
}

// final sortedCategories =  calculateCategories(state.monthlyExpenses);
// final expensesPerCat = expensePerCategory( state.monthlyExpenses);
// _logger..d('These are the expenses per category $expensesPerCat')
// ..d('These are the sorted categories $sortedCategories');
