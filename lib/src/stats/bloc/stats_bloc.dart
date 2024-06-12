import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc(this._transactionsRepository)
      : _logger = Logger(),
        super(const StatsState()) {
    on<SubscribedToCategoryAmountsEvent>(_subscribeToCategoryAmounts);
    on<DisplayIncomePieChartStats>(_displayIncomePieChart);
    on<DisplayExpensePieChartStats>(_displayExpensePieChart);
    // on<CalculateAmountsPerCategory>(_CalculateAmountsPerCategory);
  }

  final TransactionsRepository _transactionsRepository;
  final Logger _logger;

  FutureOr<void> _subscribeToCategoryAmounts(
    SubscribedToCategoryAmountsEvent event,
    Emitter<StatsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => StatsStatus.loading,
      ),
    );
    await emit.forEach<List<TransactionCategory>>(
      _transactionsRepository.getCategories(),
      onData: (transactionCategories) {
        final categories = loadCategoryAmounts(transactionCategories);
        final expenseCategories = _displayExpensesData(transactionCategories);
        final incomeCategories = _displayIncomeData(transactionCategories);
        _logger.d('These are the expenses in the stream  : ${expenseCategories}');
        _logger.d('These are the income in the stream  : ${incomeCategories}');

        return state.copyWith(
          status: () => StatsStatus.success,
          // monthlyExpenses: () => expense.reversed.toList(),
          transactionCategories: () => categories,
          expenseCategories: () => expenseCategories,
          incomeCategories: () => incomeCategories,
          isDisplayExpenses: () => true,

        );
      },
    );
  }

  ///This method calculates the total amount of expenses by category
  List<TransactionCategory> loadCategoryAmounts(
      List<TransactionCategory> categories) {
    final categoriesWithExpenses = <TransactionCategory>[];
    final uniqueCategories = <TransactionCategory>[];
    for (final category in categories) {
      // _logger.d('These are the expenses in the for loop ${category.transactions}');
      if (category.transactions.isNotEmpty) {
        categoriesWithExpenses.add(category);
      }
    }
    for (final category in categoriesWithExpenses) {
      final total = category.transactions.fold(
        0,
        (previousValue, element) => previousValue + element.amount,
      );
      category.totalAmount = total;
      uniqueCategories.add(category);

      // final uniqueCategories = categories.toSet().toList();
    }
    return uniqueCategories;
  }

  FutureOr<void> _displayIncomePieChart(
    DisplayIncomePieChartStats event,
    Emitter<StatsState> emit,
  ) {
    emit(
      state.copyWith(
        showTransactions: () => false,
        status: () => StatsStatus.success,
      ),
    );
    _logger
      ..d('display Income Pie chart should be true')
      ..d('${state.showExpenses}');
  }

  FutureOr<void> _displayExpensePieChart(
    DisplayExpensePieChartStats event,
    Emitter<StatsState> emit,
  ) {
    {
      emit(
        state.copyWith(
          showTransactions: () => true,
          status: () => StatsStatus.success,
        ),
      );
    }
  }

  List<TransactionCategory> _displayExpensesData(
      List<TransactionCategory> categories)  {
    final categoriesWithExpenses = <TransactionCategory>[];

    for (final category in categories) {
      // _logger.d('These are the expenses in the for loop ${category.transactions}');
      if (category.transactions.isNotEmpty) {
        categoriesWithExpenses.add(category);
      }
    }
    ;
    for (final category in categoriesWithExpenses) {
      final expenseTransactions =
          category.transactions.where((element) => element.isExpense);
      final total = expenseTransactions.fold(
        0,
        (previousValue, element) => previousValue + element.amount,
      );
      category.totalExpenseAmount = total;
    }

    return categoriesWithExpenses;
  }

  List<TransactionCategory> _displayIncomeData(
      List<TransactionCategory> categories)  {
    final categoriesWithTransactions = <TransactionCategory>[];
    final categoriesWithIncome = <TransactionCategory>[];

    for (final category in categories) {
      // _logger.d('These are the expenses in the for loop ${category.transactions}');
      if (category.transactions.isNotEmpty) {
        categoriesWithTransactions.add(category);
      }
    }
    ;
    for (final category in categoriesWithTransactions) {
      final incomeTransactions =
      category.transactions.where((element) => element.isIncome  );
      _logger.d(incomeTransactions);
      final total = incomeTransactions.fold(
        0,
            (previousValue, element) => previousValue + element.amount,
      );
      category.totalIncomeAmount = total;
      _logger.d('This is the total income amount: $total');
      categoriesWithIncome.add(category);
      _logger.d('These are the ccategoriesWithIncome $categoriesWithIncome');
    }

    return categoriesWithIncome;
  }
}
