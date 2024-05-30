part of 'add_transaction_bloc.dart';

final class AddTransactionEvent extends Equatable {
  const AddTransactionEvent();

  @override
  List<Object> get props => [];
}

final class Initial extends AddTransactionEvent {
  const Initial();

  @override
  List<Object> get props => [];
}

final class AddTransaction extends AddTransactionEvent{
  const AddTransaction(this.transaction);

  final Transaction transaction;
  @override
  List<Object> get props => [transaction];
}
