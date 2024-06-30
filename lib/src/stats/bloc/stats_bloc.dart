import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc(this._transactionsRepository)
      : _logger = Logger(),
        super(StatsState()) {
    on<SubscribeToTransactionsEvent>(_subscribeToTransactions);
    on<IncomeDisplayRequested>(_incomeDisplayRequested);
    on<ExpenseDisplayRequested>(_expenseDisplayRequested);
    on<DatePeriodChosenEvent>(_datePeriodChosen);
    on<CalculateTransactionsForChosenDates>(
        _calculateTransactionsForChosenDates);
    on<SubscribeToCategoriesEvent>(_subscribeToCategories);
  }

  final TransactionsRepository _transactionsRepository;
  final Logger _logger;

  FutureOr<void> _subscribeToTransactions(
    SubscribeToTransactionsEvent event,
    Emitter<StatsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => StatsStatus.loading,
      ),
    );
    await emit.forEach<List<Transaction>>(
        _transactionsRepository.getTransactions(), onData: (transactions) {
      final sortedTransactions = _transactionsByDate(transactions,
          state.selectedYear, state.selectedMonth, state.datePeriodChosen);
      _logger.d('These are the sorted transactions: $sortedTransactions');
      return state.copyWith(
        status: () => StatsStatus.success,
        transactions: () => transactions,
        sortedTransactions: () => sortedTransactions,
      );

    });
  }

  ///This method filters transactions by date
  _transactionsByDate(List<Transaction> transactions, int year, int month,
      DatePeriodChosen dateRange) {
    final transactionsByDate = transactions.where((element) {
      switch (dateRange) {
        case DatePeriodChosen.allTime:
          return true;
        case DatePeriodChosen.monthly:
          return element.dateOfTransaction.month == state.selectedMonth &&
              element.dateOfTransaction.year == state.selectedYear;
        case DatePeriodChosen.yearly:
          return element.dateOfTransaction.year == state.selectedYear;
      }
    });
    return transactionsByDate.toList();
  }

  ///This method calculates the total amount of all transactions
  List<TransactionCategory> _calculateTransactionAmountsPerCategory(
      List<Transaction> transactions) {
    final pieChartCategories = <TransactionCategory>[];
    for (final transaction in transactions) {
      final category = transaction.category;
      if (category != null) {
        final categoryIndex = pieChartCategories.indexWhere(
          (element) => element.name == category.name,
        );
        if (categoryIndex == -1) {
          pieChartCategories.add(
            TransactionCategory()
              ..name = category.name
              ..colorName = category.colorName
              ..totalAmount = transaction.amount
              ..totalExpenseAmount =
                  transaction.isExpense ? transaction.amount : 0
              ..totalIncomeAmount =
                  transaction.isIncome ? transaction.amount : 0,
          );
        } else {
          pieChartCategories[categoryIndex].totalAmount += transaction.amount;
          pieChartCategories[categoryIndex].totalExpenseAmount +=
              transaction.isExpense ? transaction.amount : 0;
          pieChartCategories[categoryIndex].totalIncomeAmount +=
              transaction.isIncome ? transaction.amount : 0;
        }
      }
    }
    return pieChartCategories;
  }

  FutureOr<void> _incomeDisplayRequested(
      IncomeDisplayRequested event, Emitter<StatsState> emit) {
    emit(
      state.copyWith(
        isDisplayIncome: () => true,
        isDisplayExpenses: () => false,
      ),
    );
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

  FutureOr<void> _expenseDisplayRequested(
      ExpenseDisplayRequested event, Emitter<StatsState> emit) {
    emit(
      state.copyWith(
        isDisplayIncome: () => false,
        isDisplayExpenses: () => true,
      ),
    );
  }

  FutureOr<void> _datePeriodChosen(
      DatePeriodChosenEvent event, Emitter<StatsState> emit) {
    switch (event.datePeriodChosen) {
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

  FutureOr<void> _calculateTransactionsForChosenDates(
      CalculateTransactionsForChosenDates event, Emitter<StatsState> emit) {
    _logger.d('This message was called from the calculate transactions event');
    final sortedTransactions = _transactionsByDate(state.transactions,
        state.selectedYear, state.selectedMonth, state.datePeriodChosen);
    emit(
      state.copyWith(
        sortedTransactions: () => sortedTransactions,
      ),
    );
  }

  FutureOr<void> _subscribeToCategories(
      SubscribeToCategoriesEvent event, Emitter<StatsState> emit) async {
    await emit.forEach<List<StoredCategory>>(
      _transactionsRepository.streamCategories(),
      onData: (categories) {
        final sortedCategories =
            _calculateTransactionAmountsPerCategory(state.transactions);
        _logger.d('These are the sorted categories: $categories');
        return state.copyWith(
          status: () => StatsStatus.success,
          sortedCategories: () => sortedCategories,
        );
      },
      onError: (_, __) => state.copyWith(status: () => StatsStatus.failure),
    );
  }
}
