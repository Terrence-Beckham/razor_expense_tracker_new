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

final class AddExpense extends AddTransactionEvent{
  const AddExpense(this.expense);

  final Expense expense;
  @override
  List<Object> get props => [expense];
}
