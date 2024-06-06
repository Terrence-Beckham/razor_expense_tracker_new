import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'transactions_overview_event.dart';
part 'transactions_overview_state.dart';

class TransactionsOverviewBloc
    extends Bloc<TransactionsOverviewEvent, TransactionsOverviewState> {
  TransactionsOverviewBloc(
    this._transactionsRepository,
  ) : super(const TransactionsOverviewState()) {
    on<TransactionsOverviewEvent>((event, emit) {});
    on<InitialDataEvent>(_loadInitialData);
  }

  final TransactionsRepository _transactionsRepository;

  late final Logger _logger;

  FutureOr<void> _loadInitialData(
    InitialDataEvent event,
    Emitter<TransactionsOverviewState> emit,
  ) async {
    state.copyWith(status: () => TransactionsOverviewStatus.loading);

    await emit.forEach<List<TransactionCategory>>(
      _transactionsRepository.getCategories(),
      onData: (categories) {
        return state.copyWith(
            status: () => TransactionsOverviewStatus.success,
            transactions: () => displayTransactions(categories));
      },
    );

    _logger = Logger();
    _logger.d(
        'This is the list of transactions stored in the db: ${state.transactions}');
  }

  List<Transaction> displayTransactions(List<TransactionCategory> categories) {
    final transactions = <Transaction>[];

    for (final category in categories) {

      transactions.addAll(category.transactions);
    }

    ///sort the transactions by date in descending order
    transactions
        .sort((a, b) => b.dateOfTransaction.compareTo(a.dateOfTransaction));
    return transactions;
  }
}
