part of 'edit_transaction_bloc.dart';

sealed class EditTransactionEvent extends Equatable {
  const EditTransactionEvent();
}

final class InitialDataEvent extends EditTransactionEvent {
  @override
  List<Object?> get props => [];
}

final class TempCategoryUpdated extends EditTransactionEvent {
  TempCategoryUpdated(this.category);

  final StoredCategory category;

  @override
  List<Object?> get props => [category];
}

final class IsCategoryExpandedUpdated extends EditTransactionEvent {
  IsCategoryExpandedUpdated();

  @override
  List<Object?> get props => [];
}

final class UpdateTransactionAmount extends EditTransactionEvent {
  UpdateTransactionAmount(this.transaction, this.amount);

  final Transaction transaction;
  final int amount;

  @override
  List<Object?> get props => [transaction, amount];
}

final class TransactionAmountError extends EditTransactionEvent{
  final bool isError;

  TransactionAmountError(this.isError);
  @override
  List<Object?> get props => [isError];


}
