part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

enum DatePeriodChosen { allTime, yearly, monthly }

final class StatsState extends Equatable {
  StatsState({
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
    this.datePeriodChosen = DatePeriodChosen.allTime,
    startMonth,
    startDate,
    endDate,
    startYear,
  })  : this.startMonth = DateTime.now().month,
        this.startYear = DateTime.now().year,
        this.startDate = (startDate != null ? startDate : DateTime.utc(0)),
        this.endDate =
            (endDate != null ? endDate : DateTime(DateTime.now().year + 9999));

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
  final DateTime? startDate;
  final DateTime? endDate;
  final DatePeriodChosen datePeriodChosen;

  ///The starting month
  final int startMonth;

  ///The starting year
  final int startYear;

  final int totalAmount;

  StatsState copyWith({
    List<Transaction> Function()? monthlyTransactions,
    StatsStatus Function()? status,
    List<PieChartDataObject> Function()? incomeCategoryTotals,
    List<PieChartDataObject> Function()? expenseCategoryTotals,
    List<TransactionCategory> Function()? transactionCategories,
    List<TransactionCategory> Function()? incomeCategories,
    List<TransactionCategory> Function()? expenseCategories,
    List<TransactionCategory> Function()? selectedTransactionCategories,
    bool Function()? showTransactions,
    int Function()? totalAmount,
    bool Function()? isDisplayExpenses,
    bool Function()? isDisplayIncome,
    final DateTime Function()? startDate,
    final DateTime Function()? endDate,
    final DatePeriodChosen Function()? datePeriodChosen,
    final int? Function()? startMonth,
    final int? Function()? startYear,
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
      startDate: startDate != null ? startDate() : this.startDate,
      endDate: endDate != null ? endDate() : this.endDate,
      datePeriodChosen:
          datePeriodChosen != null ? datePeriodChosen() : this.datePeriodChosen,
      startMonth: startMonth != null ? startMonth() : this.startMonth,
      startYear: startYear != null ? startYear() : this.startYear,
    );
  }

  @override
  List<Object?> get props => [
        startMonth,
        startYear,
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
        datePeriodChosen,
        startDate,
        endDate,
      ];
}
