import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';
import 'package:logger/logger.dart';

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
    state.copyWith(status: ()=> TransactionsOverviewStatus.success);

    await emit.forEach<List<Transaction>>(
      _transactionsRepository.getTransactions(),
      onData: (transaction) => state.copyWith(
        status: () => TransactionsOverviewStatus.success,
        transactions: () => transaction
            .reversed.toList(),
      ),
    );

    _logger = Logger();
    _logger
        .d('This is the list of transactions stored in the db: ${state.transactions}');
  }
}
