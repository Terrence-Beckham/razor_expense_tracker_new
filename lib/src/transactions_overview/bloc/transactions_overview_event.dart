part of 'transactions_overview_bloc.dart';

abstract class TransactionsOverviewEvent extends Equatable {
  const TransactionsOverviewEvent();
}

final class InitialDataEvent extends TransactionsOverviewEvent{
  const InitialDataEvent();

  @override
  List<Object?> get props =>[];

}

final class DeleteTransactionEvent extends TransactionsOverviewEvent{
  const DeleteTransactionEvent(this.transaction);

  final Transaction transaction;

  @override
  List<Object?> get props => [transaction];
}

final class UndoDeleteTransactionEvent extends TransactionsOverviewEvent{
  const UndoDeleteTransactionEvent(this.transaction ) ;

  final Transaction transaction;

  @override
  List<Object?> get props => [transaction];
}
