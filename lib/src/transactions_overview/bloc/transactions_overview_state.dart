part of 'transactions_overview_bloc.dart';

enum TransactionsOverviewStatus { initial, loading, success, failure }

final class TransactionsOverviewState extends Equatable {
  const TransactionsOverviewState({
    this.status = TransactionsOverviewStatus.success,
    this.transactions = const [],
    this.incomeTotals = 0,
    this.expenseTotals = 0,
    this.balance = 0,
    this.deletedTransaction ,
  });

  final TransactionsOverviewStatus status;
  final List<Transaction> transactions;
  final int incomeTotals;
  final int expenseTotals;
  final int balance;
  final Transaction? deletedTransaction;

  TransactionsOverviewState copyWith({
    TransactionsOverviewStatus Function()? status,
    List<Transaction> Function()? transactions,
    int Function()? incomeTotals,
    int Function()? expenseTotals,
    int Function()? balance,
    Transaction? Function()? deletedTransaction,
  }) {
    return TransactionsOverviewState(
      status: status != null ? status() : this.status,
      transactions: transactions != null ? transactions() : this.transactions,
      incomeTotals: incomeTotals != null ? incomeTotals() : this.incomeTotals,
      expenseTotals:
          expenseTotals != null ? expenseTotals() : this.expenseTotals,
      balance: balance != null ? balance() : this.balance,
      deletedTransaction: deletedTransaction != null
          ? deletedTransaction()
          : this.deletedTransaction,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transactions,
        incomeTotals,
        expenseTotals,
        balance,
        deletedTransaction,
      ];
}
