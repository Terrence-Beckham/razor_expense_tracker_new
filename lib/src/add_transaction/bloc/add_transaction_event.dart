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

/// This class updates the selectedIcon field in the AddTransactionState
final class UpdateSelectedIcon extends AddTransactionEvent {
  const UpdateSelectedIcon(this.icon);

  final Icon icon;

  @override
  List<Object> get props => [icon];
}

/// This class updates the selectedColor field in the AddTransactionState class
final class UpdateSelectedColor extends AddTransactionEvent {
  const UpdateSelectedColor(this.color);

  final Color color;

  @override
  List<Object> get props => [color];
}



/// This class updates the selectedCategory field in the AddTransactionState class
final class UpdateSelectedCategory extends AddTransactionEvent {
  const UpdateSelectedCategory(this.category);

  final TransactionCategory category;

  @override
  List<Object> get props => [category];
}
/// This class updates the isExpense field in the AddTransactionState class
final class UpdateIsExpense extends AddTransactionEvent {
  const UpdateIsExpense(this.isExpense);

  final bool isExpense;

  @override
  List<Object> get props => [isExpense];
}
/// This class updates the isIncome field in the AddTransactionState class
final class UpdateIsIncome extends AddTransactionEvent {
  const UpdateIsIncome(this.isIncome);

  final bool isIncome;

  @override
  List<Object> get props => [isIncome];
}
/// This class updates the isCategoryExpanded field in the AddTransactionState class
final class UpdateIsCategoryExpanded extends AddTransactionEvent {
  const UpdateIsCategoryExpanded(this.isCategoryExpanded);

  final bool isCategoryExpanded;

  @override
  List<Object> get props => [isCategoryExpanded];
}

///This class updates the isColorExpanded field in the AddTransactionState class
final class UpdateIsColorExpanded extends AddTransactionEvent {
  const UpdateIsColorExpanded(this.isColorExpanded);

  final bool isColorExpanded;

  @override
  List<Object> get props => [isColorExpanded];
}
/// This class updates the isCategorySelected field in the AddTransactionState class
final class UpdateIsCategorySelected extends AddTransactionEvent {
  const UpdateIsCategorySelected(this.isCategorySelected);

  final bool isCategorySelected;

  @override
  List<Object> get props => [isCategorySelected];
}
/// This class updates the tempCategory field in the AddTransactionState class
final class UpdateTempCategory extends AddTransactionEvent {
  const UpdateTempCategory(this.category);

  final TransactionCategory category;

  @override
  List<Object> get props => [category];
}
/// This class updates the dateTextController field in the AddTransactionState class
final class UpdateDateTextField extends AddTransactionEvent {
  const UpdateDateTextField(this.dateTextValue);

  final String dateTextValue;

  @override
  List<Object> get props => [dateTextValue];
}
/// This class updates the transactionAmountController field in the AddTransactionState class
final class UpdateTransactionAmountField extends AddTransactionEvent {
  const UpdateTransactionAmountField(this.transactionAmount);

  final String transactionAmount;

  @override
  List<Object> get props => [transactionAmount];
}
/// This class updates the isDateChoosen field in the AddTransactionState class
final class UpdateIsDateChoosen extends AddTransactionEvent {
  const UpdateIsDateChoosen(this.isDateChoosen);

  final bool isDateChoosen;

  @override
  List<Object> get props => [isDateChoosen];
}
/// This class updates the tempDate field in the AddTransactionState class
final class UpdateTempDate extends AddTransactionEvent {
  const UpdateTempDate(this.tempDate);

  final DateTime tempDate;

  @override
  List<Object> get props => [tempDate];
}
/// This class updates the tempTransaction field in the AddTransactionState class
final class UpdateTempTransaction extends AddTransactionEvent {
  const UpdateTempTransaction(this.tempTransaction);

  final Transaction tempTransaction;

  @override
  List<Object> get props => [tempTransaction];
}

/// This class updates the status field in the AddTransactionState class
final class UpdateStatus extends AddTransactionEvent {
  const UpdateStatus(this.status);

  final AddTransactionStatus status;

  @override
  List<Object> get props => [status];
}


/// This class updates the categories field in the AddTransactionState class
final class UpdateCategories extends AddTransactionEvent {
  const UpdateCategories(this.categories);

  final List<TransactionCategory> categories;

  @override
  List<Object> get props => [categories];
}

///Save Transaction to TransactionCategory
final class SaveTransactionToCategory extends AddTransactionEvent {
  const SaveTransactionToCategory(this.transaction, this.categoryId);

  final Transaction transaction;
  final int categoryId;

  @override
  List<Object> get props => [transaction, categoryId];
}