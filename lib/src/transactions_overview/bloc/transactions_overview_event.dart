part of 'transactions_overview_bloc.dart';

abstract class TransactionsOverviewEvent extends Equatable {
  const TransactionsOverviewEvent();
}

final class InitialDataEvent extends TransactionsOverviewEvent{
  const InitialDataEvent();

  @override
  List<Object?> get props =>[];

}
