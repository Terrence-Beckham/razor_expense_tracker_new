part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

final class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.initial,
    this.monthlyTransactions = const [],
    this.incomeCategoryTotals = const [],
    this.expenseCategoryTotals = const [],
    this.selectedTransactionCategories = const [],
    this.incomeCategories = const [],
    this.expenseCategories = const [],
    this.totalAmount = 0,
    this.showExpenses = true,
    this.isDisplayExpenses = true,
    this.isDisplayIncome = false,
  });

  final List<Transaction> monthlyTransactions;
  final StatsStatus status;
  final List<PieChartDataObject> expenseCategoryTotals;
  final List<PieChartDataObject> incomeCategoryTotals;
  final List<TransactionCategory> selectedTransactionCategories;
  final List<TransactionCategory> incomeCategories;
  final List<TransactionCategory> expenseCategories;
  final bool showExpenses;
  final bool isDisplayExpenses;
  final bool isDisplayIncome;

  final int totalAmount;

  StatsState copyWith({
    List<Transaction> Function()? monthlyTransactions,
    StatsStatus Function()? status,
    List<PieChartDataObject> Function()? incomeCategoryTotals,
    List<PieChartDataObject> Function()? expenseCategoryTotals,
    List<TransactionCategory> Function()? transactionCategories,
    List<TransactionCategory> Function()? incomeCategories,
    List<TransactionCategory> Function()? expenseCategories,
    bool Function()? showTransactions,
    int Function()? totalAmount,
    bool Function()? isDisplayExpenses,
    bool Function()? isDisplayIncome,
  }) {
    return StatsState(
      showExpenses:
          showTransactions != null ? showTransactions() : this.showExpenses,
      selectedTransactionCategories: transactionCategories != null
          ? transactionCategories()
          : this.selectedTransactionCategories,
      incomeCategories:
          incomeCategories != null ? incomeCategories() : this.incomeCategories,
      expenseCategories: expenseCategories != null
          ? expenseCategories()
          : this.expenseCategories,
      monthlyTransactions: monthlyTransactions != null
          ? monthlyTransactions()
          : this.monthlyTransactions,
      status: status != null ? status() : this.status,
      incomeCategoryTotals: incomeCategoryTotals != null
          ? incomeCategoryTotals()
          : this.incomeCategoryTotals,
      expenseCategoryTotals: expenseCategoryTotals != null
          ? expenseCategoryTotals()
          : this.expenseCategoryTotals,
      totalAmount: totalAmount != null ? totalAmount() : this.totalAmount,
      isDisplayExpenses: isDisplayExpenses != null
          ? isDisplayExpenses()
          : this.isDisplayExpenses,
      isDisplayIncome:
          isDisplayIncome != null ? isDisplayIncome() : this.isDisplayIncome,
    );
  }

  @override
  List<Object?> get props => [
        monthlyTransactions,
        status,
        incomeCategoryTotals,
        expenseCategoryTotals,
        showExpenses,
        selectedTransactionCategories,
        totalAmount,
        isDisplayExpenses,
        isDisplayIncome,
        incomeCategories,
        expenseCategories,
      ];
}
