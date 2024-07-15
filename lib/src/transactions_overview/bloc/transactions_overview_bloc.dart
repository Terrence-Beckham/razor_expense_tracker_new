import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:settings_api/models/local_setting.dart';
import 'package:settings_repo/settings_repo.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'transactions_overview_event.dart';
part 'transactions_overview_state.dart';

class TransactionsOverviewBloc
    extends Bloc<TransactionsOverviewEvent, TransactionsOverviewState> {
  TransactionsOverviewBloc(this._transactionsRepo, this._settingsRepo)
      : _logger = Logger(),
        super(const TransactionsOverviewState()) {
    on<TransactionsOverviewEvent>((event, emit) {});
    on<InitialDataEvent>(_loadInitialData);
    on<DeleteTransactionEvent>(_deleteTransaction);
    on<UndoDeleteTransactionEvent>(_undoDeleteTransaction);
    on<TransactionsRequestedEvent>(_requestTransactions);
    on<GetSettingsEvent>(_getSettingsStream);
  }

  final TransactionsRepo _transactionsRepo;
  final SettingsRepo _settingsRepo;

  final Logger _logger;

  FutureOr<void> _loadInitialData(
    InitialDataEvent event,
    Emitter<TransactionsOverviewState> emit,
  ) async {
    state.copyWith(status: () => TransactionsOverviewStatus.loading);
    _logger.d("It should be loading now.");
    await emit.forEach<List<Transaction>>(
      _transactionsRepo.transactionStream(),
      onData: (transactions) {
        final reversedTransactions = transactions.reversed.toList();
        return state.copyWith(
          status: () => TransactionsOverviewStatus.success,
          transactions: () => reversedTransactions,
          incomeTotals: () => calculateTotalIncome(transactions),
          expenseTotals: () => calculateTotalExpenses(transactions),
          balance: () => calculateTotalBalance(transactions),
        );
      },
    );

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
    _transactionsRepo.deleteTransaction(event.transaction);
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
    _transactionsRepo.saveTransaction(
      event.transaction,
    );
    emit(
      state.copyWith(
        status: () => TransactionsOverviewStatus.success,
        deletedTransaction: () => null,
      ),
    );
  }

  FutureOr<void> _requestTransactions(TransactionsRequestedEvent event,
      Emitter<TransactionsOverviewState> emit) {
    state.copyWith(status: () => TransactionsOverviewStatus.loading);

    _transactionsRepo.getTransactions();
  }

  FutureOr<void> _getSettingsStream(
      GetSettingsEvent event, Emitter<TransactionsOverviewState> emit) async {
    await emit.forEach(
      _settingsRepo.settingsStream(),
      onData: (setting) => state.copyWith(
        localSetting: () => setting,
        status: () => TransactionsOverviewStatus.success,
      ),
    );
  }
}
