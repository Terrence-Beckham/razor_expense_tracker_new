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
    on<SubscribeToCategoriesEvent>(_subscribeToCategories);
    on<SelectedMonthChanged>(_changeSelectedMonth);
    on<SelectedYearChanged>(_changeSelectedYear);
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
        _transactionsRepository.transactionStream(), onData: (transactions) {
      ///todo I have to query the transactions that I need here
      final sortedTransactions = _transactionsByDate(
          transactions,
          state.selectedYear,
          state.selectedMonth.month,
          state.datePeriodChosen);
      final sortedCategories =
          _calculateTransactionAmountsPerCategory(sortedTransactions);

      ///todo I have to sort the transactions here, then I have to add up the expense amount totals
      ///to get the percentages
      final (expenseTotals, incomeTotals) =
          _calculateTotalAmounts(transactions);
      return state.copyWith(
        status: () => StatsStatus.success,
        sortedCategories: () => sortedCategories,
        expenseTransactionTotals: () => expenseTotals.toDouble(),
        incomeTransactionTotals: () => incomeTotals.toDouble(),
      );
    });
  }

  ///This method filters transactions by date
  List<Transaction> _transactionsByDate(List<Transaction> transactions,
      int year, int month, DatePeriodChosen dateRange) {
    final transactionsByDate = transactions.where((element) {
      switch (dateRange) {
        case DatePeriodChosen.allTime:
          return true;
        case DatePeriodChosen.monthly:
          return element.dateOfTransaction.month == state.selectedMonth.month &&
              element.dateOfTransaction.year == state.selectedYear;
        case DatePeriodChosen.yearly:
          return element.dateOfTransaction.year == state.selectedYear;
      }
    });
    _logger.d('transactions by date $transactionsByDate');
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
    _logger.d('list of piechart categories $pieChartCategories');
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
            selectedMonth: () => dateLabelMapper[DateTime.now().month]!,
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

  FutureOr<void> _subscribeToCategories(
      SubscribeToCategoriesEvent event, Emitter<StatsState> emit) async {
    await emit.forEach<List<StoredCategory>>(
      _transactionsRepository.sortedCategoryStream(),
      onData: (categories) {
        final sortedCategories =
            _calculateTransactionAmountsPerCategory(state.transactions);
        // _logger.d('These are the sorted categories: $categories');
        return state.copyWith(
          status: () => StatsStatus.success,
          sortedCategories: () => sortedCategories,
        );
      },
      onError: (_, __) => state.copyWith(status: () => StatsStatus.failure),
    );
  }

  (double, double) _calculateTotalAmounts(List<Transaction> transactions) {
    var expenseTotal = 0.0;
    var incomeTotal = 0.0;
    for (final transaction in transactions) {
      if (transaction.isExpense) {
        expenseTotal += transaction.amount;
      }
      if (transaction.isIncome) {
        incomeTotal += transaction.amount;
      }
    }
    return (expenseTotal, incomeTotal);
  }

  FutureOr<void> _changeSelectedMonth(
      SelectedMonthChanged event, Emitter<StatsState> emit) {
    emit(state.copyWith(
        status: () => StatsStatus.success,
        selectedMonth: () => event.selectedMonth));
    _logger.d('This is the  month that was sent ${event.selectedMonth}');
    _logger.d('This is the month that was selected ${state.selectedMonth}');
  }

  FutureOr<void> _changeSelectedYear(
      SelectedYearChanged event, Emitter<StatsState> emit) {
    emit(state.copyWith(
        status: () => StatsStatus.success,
        selectedYear: () => event.selectedYear));
  }
}
