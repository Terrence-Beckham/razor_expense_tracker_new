part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

enum DatePeriodChosen { allTime, yearly, monthly }

final class StatsState extends Equatable {
  StatsState({
    this.status = StatsStatus.initial,
    this.transactions = const [],
    this.sortedTransactions = const [],
    this.categories = const [],
    this.sortedCategories = const [],
    this.totalAmount = 0,
    this.isDisplayExpenses = true,
    this.isDisplayIncome = false,
    this.datePeriodChosen = DatePeriodChosen.allTime,
    this.expenseTransactions = const [],
    this.incomeTransactions = const [],
    selectedMonth,
    selectedYear,
  })  : this.selectedMonth = DateTime.now().month + 1,
        this.selectedYear = DateTime.now().year;

  ///This is the raw list of transactions from the database
  final List<Transaction> transactions;

  ///This is a list of Transactions that had been filtered by date
  final List<Transaction> sortedTransactions;

  ///This is a list of categories after the transactions have been sorted and the amounts calculated
  final List<TransactionCategory> sortedCategories;

  ///This is the status of the stats state
  final StatsStatus status;

  ///This is the list of all transaction categories
  final List<TransactionCategory> categories;

  /// Set to true if the user wants to display expenses
  final bool isDisplayExpenses;

  /// Set to true if the user wants to display income
  final bool isDisplayIncome;

  /// The date period chosen by the user
  final DatePeriodChosen datePeriodChosen;

  /// The list of transactions that are expenses
  final expenseTransactions;

  /// The list of transactions that are income
  final incomeTransactions;

  /// The selected month for the stats
  final int selectedMonth;

  /// The selected year for the stats
  final int selectedYear;

  /// The total amount of all transactions
  final int totalAmount;

  StatsState copyWith({
    List<Transaction> Function()? transactions,
    StatsStatus Function()? status,
    List<TransactionCategory> Function()? categories,
    List<Transaction> Function()? sortedTransactions,
    List<TransactionCategory> Function()? sortedCategories,
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
      categories: categories != null ? categories() : this.categories,
      transactions: transactions != null ? transactions() : this.transactions,
      sortedCategories:
          sortedCategories != null ? sortedCategories() : this.sortedCategories,
      status: status != null ? status() : this.status,
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
  List<Object> get props => [
        transactions,
        sortedTransactions,
        sortedCategories,
        status,
        categories,
        isDisplayExpenses,
        isDisplayIncome,
        datePeriodChosen,
        expenseTransactions,
        incomeTransactions,
        selectedMonth,
        selectedYear,
        totalAmount,
      ];
}
