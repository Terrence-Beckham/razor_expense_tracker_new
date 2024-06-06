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
        final categories =loadCategoryAmounts(transactionCategories);
        // final categories = transactionCategories;

       // final uniqueCategories = loadCategoryAmounts(categories);
        _logger.i(
            'These are the category totals in the stream  : ${transactionCategories}');
        return state.copyWith(
          status: () => StatsStatus.success,
          // monthlyExpenses: () => expense.reversed.toList(),
          transactionCategories: () => categories,
        );
      },
    );
  }

  ///This method calculates the total amount of expenses by category
  List<TransactionCategory> loadCategoryAmounts(
      List<TransactionCategory> categories) {
    _logger.d('these are the categories in loadCategory $categories');

    final categoriesWithExpenses = <TransactionCategory>[];
    final uniqueCategories = <TransactionCategory>[];
    for (final category in categories) {
      // _logger.d('These are the expenses in the for loop ${category.transactions}');
      if (category.transactions.isNotEmpty) {
        categoriesWithExpenses.add(category);
        _logger.e(
          'These are the categories with expenses $categoriesWithExpenses',
        );
      }
    }
    for (final category in categoriesWithExpenses) {
      final total = category.transactions.fold(
        0,
        (previousValue, element) => previousValue + element.amount,
      );
      _logger.i('This is the numnber of transactions per ${category.name}:  ${category.transactions.length}');
      category.amount = total;
      _logger.e(
          'This is the total amount for the categories that have expenses ${category.name} $total');
      uniqueCategories.add(category);

      // final uniqueCategories = categories.toSet().toList();

      _logger
          .e('These are the categories with expenses $categoriesWithExpenses');
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
}

