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
  )   : _logger = Logger(),
        super(const TransactionsOverviewState()) {
    on<TransactionsOverviewEvent>((event, emit) {});
    on<InitialDataEvent>(_loadInitialData);
    on<DeleteTransactionEvent>(_deleteTransaction);
    on<UndoDeleteTransactionEvent>(_undoDeleteTransaction);
  }

  final TransactionsRepository _transactionsRepository;

  late final Logger _logger;

  FutureOr<void> _loadInitialData(
    InitialDataEvent event,
    Emitter<TransactionsOverviewState> emit,
  ) async {
    state.copyWith(status: () => TransactionsOverviewStatus.loading);

    await emit.forEach<List<Transaction>>(
      _transactionsRepository.getTransactions(),
      onData: (transactions) {
        return state.copyWith(
          status: () => TransactionsOverviewStatus.success,
          transactions: () => transactions,
          incomeTotals: () => calculateTotalIncome(transactions),
          expenseTotals: () => calculateTotalExpenses(transactions),
          balance: () => calculateTotalBalance(transactions),
        );
      },
    );

    _logger = Logger();
    _logger.d(
        'This is the list of transactions stored in the db: ${state.transactions}');
  }

  int calculateTotalExpenses(List<Transaction> transactions) {
    var expenseTotal = 0;
    for (final transaction in transactions) {
      if (transaction.isExpense) {
        expenseTotal += transaction.amount;
      }
    }
    return expenseTotal;
  }

  int calculateTotalIncome(List<Transaction> transactions) {
    var incomeTotal = 0;
    for (final transaction in transactions) {
      if (transaction.isIncome) {
        incomeTotal += transaction.amount;
      }
    }
    return incomeTotal;
  }

  int calculateTotalBalance(List<Transaction> transactions) {
    var balance = 0;
    for (final transaction in transactions) {
      if (transaction.isIncome) {
        balance += transaction.amount;
      } else {
        balance -= transaction.amount;
      }
    }
    return balance;
  }

  FutureOr<void> _deleteTransaction(
      event, Emitter<TransactionsOverviewState> emit) {
    _transactionsRepository.deleteTransaction(event.transaction);
    emit(
      state.copyWith(
        status: () => TransactionsOverviewStatus.success,
        deletedTransaction: () => event.transaction,
      ),
    );
  }

  FutureOr<void> _undoDeleteTransaction(UndoDeleteTransactionEvent event,
      Emitter<TransactionsOverviewState> emit) {
    _logger.d('${state.deletedTransaction}');
    _transactionsRepository.reSaveTransaction(event.transaction);
    emit(
      state.copyWith(
        status: () => TransactionsOverviewStatus.success,
        deletedTransaction: () => null,
      ),
    );
  }
}
