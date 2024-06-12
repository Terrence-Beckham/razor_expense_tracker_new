part of 'add_transaction_bloc.dart';

enum AddTransactionStatus {
  initial,
  loading,
  success,
  failure,
  addNewCategory,
  chooseCategory
}

class AddTransactionState extends Equatable {
  final AddTransactionStatus status;
  final List<TransactionCategory> categories;
  final Icon selectedIcon;
  final Color selectedColor;
  final String selectedTransactionType;
  final bool isExpense;
  final bool isIncome;
  final bool isCategoryExpanded;
  final bool isColorExpanded;
  final bool isCategorySelected;
  final TransactionCategory tempCategory;
  final String dateTextField;
  final String transactionAmount;
  final bool isDateChosen;
  final DateTime tempDate;
  final Transaction tempTransaction;
  final TransactionCategory newCustomCategory;
  final bool isAddNewCategoryExpanded;
  final List<Icon> categoryWidgetIcons;
  final bool isAddNewCategoryColorPickerExpanded;

  AddTransactionState({
    required this.newCustomCategory,
    required this.isAddNewCategoryColorPickerExpanded,
    required this.isColorExpanded,
    required this.tempDate,
    required this.categories,
    required this.status,
    required this.selectedIcon,
    required this.selectedColor,
    required this.selectedTransactionType,
    required this.isExpense,
    required this.isIncome,
    required this.isCategoryExpanded,
    required this.isCategorySelected,
    required this.isDateChosen,
    required this.isAddNewCategoryExpanded,
    required this.tempCategory,
    required this.dateTextField,
    required this.transactionAmount,
    required this.tempTransaction,
    required this.categoryWidgetIcons,
  });

  AddTransactionState copyWith({
    TransactionCategory Function()? newCustomCategory,
    AddTransactionStatus Function()? status,
    List<TransactionCategory> Function()? categories,
    List<Icon> Function()? categoryWidgetIcons,
    Icon Function()? selectedIcon,
    Color Function()? selectedColor,
    String Function()? selectedTransactionType,
    bool Function()? isExpense,
    bool Function()? isAddNewCategoryColorPickerExpanded,
    bool Function()? isAddNewCategoryExpanded,
    bool Function()? isIncome,
    bool Function()? isCategoryExpanded,
    bool Function()? isCategorySelected,
    TransactionCategory Function()? tempCategory,
    String Function()? dateTextField,
    String Function()? transactionAmountController,
    bool Function()? isDateChoosen,
    bool Function()? isColorExpanded,
    DateTime Function()? tempDate,
    Transaction Function()? tempTransaction,
  }) {
    return AddTransactionState(
      newCustomCategory: newCustomCategory != null
          ? newCustomCategory()
          : this.newCustomCategory,
      isAddNewCategoryColorPickerExpanded:
          isAddNewCategoryColorPickerExpanded != null
              ? isAddNewCategoryColorPickerExpanded()
              : this.isAddNewCategoryColorPickerExpanded,
      categoryWidgetIcons: categoryWidgetIcons != null
          ? categoryWidgetIcons()
          : this.categoryWidgetIcons,
      isColorExpanded:
          isColorExpanded != null ? isColorExpanded() : this.isColorExpanded,
      status: status != null ? status() : this.status,
      categories: categories != null ? categories() : this.categories,
      selectedIcon: selectedIcon != null ? selectedIcon() : this.selectedIcon,
      selectedColor:
          selectedColor != null ? selectedColor() : this.selectedColor,
      selectedTransactionType: selectedTransactionType != null
          ? selectedTransactionType()
          : this.selectedTransactionType,
      isExpense: isExpense != null ? isExpense() : this.isExpense,
      isIncome: isIncome != null ? isIncome() : this.isIncome,
      isAddNewCategoryExpanded: isAddNewCategoryExpanded != null
          ? isAddNewCategoryExpanded()
          : this.isAddNewCategoryExpanded,
      isCategoryExpanded: isCategoryExpanded != null
          ? isCategoryExpanded()
          : this.isCategoryExpanded,
      isCategorySelected: isCategorySelected != null
          ? isCategorySelected()
          : this.isCategorySelected,
      tempCategory: tempCategory != null ? tempCategory() : this.tempCategory,
      dateTextField:
          dateTextField != null ? dateTextField() : this.dateTextField,
      transactionAmount: transactionAmountController != null
          ? transactionAmountController()
          : this.transactionAmount,
      isDateChosen: isDateChoosen != null ? isDateChoosen() : this.isDateChosen,
      tempDate: tempDate != null ? tempDate() : this.tempDate,
      tempTransaction:
          tempTransaction != null ? tempTransaction() : this.tempTransaction,
    );
  }

  AddTransactionState.empty()
      : status = AddTransactionStatus.initial,
        newCustomCategory = TransactionCategory(),
        categoryWidgetIcons = categoryWidgets,
        categories = [],
        isColorExpanded = false,
        isAddNewCategoryColorPickerExpanded = false,
        selectedIcon = Icon(Icons.category),
        selectedColor = Colors.red,
        selectedTransactionType = "income",
        isExpense = true,
        isIncome = false,
        isCategoryExpanded = false,
        isCategorySelected = false,
        isAddNewCategoryExpanded = false,
        tempCategory = TransactionCategory(),
        dateTextField = 'Choose Date',
        transactionAmount = '0',
        isDateChosen = false,
        tempDate = DateTime.now(),
        tempTransaction = Transaction();

  @override
  List<Object> get props => [
        status,
        categories,
        selectedIcon,
        selectedColor,
        selectedTransactionType,
        isExpense,
        isIncome,
        isCategoryExpanded,
        isCategorySelected,
        isAddNewCategoryExpanded,
        tempCategory,
        dateTextField,
        transactionAmount,
        isDateChosen,
        tempDate,
        tempTransaction,
        isAddNewCategoryColorPickerExpanded,
        newCustomCategory,
        isColorExpanded,
      ];
}
