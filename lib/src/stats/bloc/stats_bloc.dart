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
        super(StatsState()) {
    on<SubscribedToCategoryAmountsEvent>(_subscribeToCategoryAmounts);
    on<IncomeDisplayRequested>(_incomeDisplayRequested);
    on<ExpenseDisplayRequested>(_expenseDisplayRequested);
    on<DatePeriodChosenEvent>(_datePeriodChosen);

  }

  final TransactionsRepository _transactionsRepository;
  final Logger _logger;

  FutureOr<void> _subscribeToCategoryAmounts(
      SubscribedToCategoryAmountsEvent event,
      Emitter<StatsState> emit,) async {
    emit(
      state.copyWith(
        status: () => StatsStatus.loading,
      ),
    );
    await emit.forEach<List<TransactionCategory>>(
      _transactionsRepository.streamCategories(),
      onData: (transactionCategories) {
        final categories = loadCategoryAmounts(transactionCategories);
        final sortedCategoriesByType =
        _sortTransactionsByType(transactionCategories);
        _logger.d(
            'These are the expenses in the stream  : ${sortedCategoriesByType}');
        final categoriesWithPercentages =
        _calculateCategoryPercentages(sortedCategoriesByType);
        return state.copyWith(
          status: () => StatsStatus.success,
          // monthlyExpenses: () => expense.reversed.toList(),
          transactionCategories: () => categories,
          selectedTransactionCategories: () => categoriesWithPercentages,
          isDisplayExpenses: () => true,
        );
      },
    );
    _logger.d(
        'These are the categories with only expenses  : ${state
            .selectedTransactionCategories}');
    _logger.d(
        'These are the categories with only income  : ${state
            .selectedTransactionCategories}');
  }

  ///This method calculates the total amount of expenses by category
  List<TransactionCategory> loadCategoryAmounts(
      List<TransactionCategory> categories) {
    final categoriesWithExpenses = <TransactionCategory>[];
    final uniqueCategories = <TransactionCategory>[];
    final categoriesWithDateRangeData = <TransactionCategory>[];
    for (final category in categories) {
      // _logger.d('These are the expenses in the for loop ${category.transactions}');
      if (category.transactions.isNotEmpty) {
        categoriesWithExpenses.add(category);
      }
    }
    for (final category in categoriesWithExpenses) {
      ///Todo I need to have another function here that only adds the transactions that
      ///match the date I request
      _transactionByDateTime(category, state.datePeriodChosen);
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

  List<TransactionCategory> _sortTransactionsByType(
      List<TransactionCategory> categories) {
    final categoriesWithExpenses = <TransactionCategory>[];
    final sortedCategories = <TransactionCategory>[];

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
      sortedCategories.add(category);
    }

    for (final category in categoriesWithExpenses) {
      final incomeTransactions =
      category.transactions.where((element) => element.isIncome);
      final total = incomeTransactions.fold(
        0,
            (previousValue, element) => previousValue + element.amount,
      );
      category.totalIncomeAmount = total;
      sortedCategories.add(category);
    }
    _logger.d('These are the sorted Categories: $sortedCategories');
    return sortedCategories;
  }

  List<TransactionCategory> _calculateCategoryPercentages(
      List<TransactionCategory> categories) {
    final totalSum = categories.fold(
        0, (previousValue, element) => previousValue + element.totalAmount);
    final categoriesWithPercentages = <TransactionCategory>[];
    for (final category in categories) {
      final expensePercentage = (category.totalExpenseAmount / totalSum) * 100;
      final incomePercentage = (category.totalIncomeAmount / totalSum) * 100;
      category.expensePercentage = expensePercentage.toStringAsFixed(1);
      _logger.d(
          'These is the percentage of expenses in this category ${category}');
      category.incomePercentage = incomePercentage.toStringAsFixed(1);
      categoriesWithPercentages.add(category);
    }
    return categoriesWithPercentages;
  }

  FutureOr<void> _incomeDisplayRequested(IncomeDisplayRequested event,
      Emitter<StatsState> emit) {
    emit(
      state.copyWith(
        isDisplayIncome: () => true,
        isDisplayExpenses: () => false,
      ),
    );
  }

  FutureOr<void> _expenseDisplayRequested(ExpenseDisplayRequested event,
      Emitter<StatsState> emit) {
    emit(
      state.copyWith(
        isDisplayIncome: () => false,
        isDisplayExpenses: () => true,
      ),
    );
  }

  TransactionCategory _transactionByDateTime(TransactionCategory category, DatePeriodChosen datePeriodChosen) {



  }

    FutureOr<void> _datePeriodChosen(
    DatePeriodChosenEvent event, Emitter<StatsState> emit) {
    switch(event.datePeriodChosen){
    case DatePeriodChosen.allTime:
    emit(
    state.copyWith(
    datePeriodChosen: () => DatePeriodChosen.allTime,
    ),
    );
    break;
    case DatePeriodChosen.monthly:
    emit(
    state.copyWith(
    datePeriodChosen: () => DatePeriodChosen.monthly,
    ),
    );
    break;
    case DatePeriodChosen.yearly:
    emit(
    state.copyWith(
    datePeriodChosen: () => DatePeriodChosen.yearly,
    ),
    );
    break;
    }


    }
  }
