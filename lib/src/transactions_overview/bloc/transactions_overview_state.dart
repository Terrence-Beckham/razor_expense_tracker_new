part of 'transactions_overview_bloc.dart';

enum TransactionsOverviewStatus { initial, loading, success, failure }

final class TransactionsOverviewState extends Equatable {
  const TransactionsOverviewState({
    this.status = TransactionsOverviewStatus.success,
    this.transactions = const [],
  });

  final TransactionsOverviewStatus status;
  final List<Transaction> transactions;

  TransactionsOverviewState copyWith({
    TransactionsOverviewStatus Function()? status,
    List<Transaction> Function()? transactions,
  }) {
    return TransactionsOverviewState(
      status: status != null ? status() : this.status,
      transactions: transactions != null ? transactions() : this.transactions,
    );
  }

  @override
  List<Object?> get props => [status, transactions];
}
