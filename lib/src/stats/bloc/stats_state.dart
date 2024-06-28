part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

enum DatePeriodChosen { allTime, yearly, monthly }

final class StatsState extends Equatable {
  StatsState({
    this.status = StatsStatus.initial,
    this.transactions = const [],
    this.incomeCategoryTotals = const [],
    this.expenseCategoryTotals = const [],
    this.selectedTransactionCategories = const [],
    this.incomeCategories = const [],
    this.expenseCategories = const [],
    this.totalAmount = 0,
    this.showExpenses = true,
    this.isDisplayExpenses = true,
    this.isDisplayIncome = false,
    this.datePeriodChosen = DatePeriodChosen.allTime,
    this.expenseTransactions = const [],
    this.incomeTransactions = const [],
    selectedMonth,
    selectedYear,
  })  : this.selectedMonth = DateTime.now().month,
        this.selectedYear = DateTime.now().year;
  final List<Transaction> transactions;
  final StatsStatus status;
  final List<PieChartDataObject> expenseCategoryTotals;
  final List<PieChartDataObject> incomeCategoryTotals;
  final List<TransactionCategory> selectedTransactionCategories;
  final List<TransactionCategory> incomeCategories;
  final List<TransactionCategory> expenseCategories;
  final bool showExpenses;
  final bool isDisplayExpenses;
  final bool isDisplayIncome;
  final DatePeriodChosen datePeriodChosen;
  final expenseTransactions;
  final incomeTransactions;
final int selectedMonth;
final int selectedYear;


  final int totalAmount;

  StatsState copyWith({
    List<Transaction> Function()? transactions,
    StatsStatus Function()? status,
    List<PieChartDataObject> Function()? incomeCategoryTotals,
    List<PieChartDataObject> Function()? expenseCategoryTotals,
    List<TransactionCategory> Function()? transactionCategories,
    List<TransactionCategory> Function()? incomeCategories,
    List<TransactionCategory> Function()? expenseCategories,
    List<TransactionCategory> Function()? selectedTransactionCategories,
    List<Transaction> Function()? expenseTransactions,
    List<Transaction> Function()? incomeTransactions,
    bool Function()? showTransactions,
    int Function()? totalAmount,
    bool Function()? isDisplayExpenses,
    bool Function()? isDisplayIncome,
     DatePeriodChosen Function()? datePeriodChosen,
     int Function()? selectedMonth,
     int Function()? selectedYear,
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
      transactions: transactions != null ? transactions() : this.transactions,
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
      datePeriodChosen:
      datePeriodChosen != null ? datePeriodChosen() : this.datePeriodChosen,

      expenseTransactions: expenseTransactions != null
          ? expenseTransactions()
          : this.expenseTransactions,
      incomeTransactions: incomeTransactions != null
          ? incomeTransactions()
          : this.incomeTransactions,
    );
  }

  @override
  List<Object?> get props => [
        selectedYear,
        selectedMonth,
        transactions,
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
        datePeriodChosen,
        expenseTransactions,
        incomeTransactions,
      ];
}
