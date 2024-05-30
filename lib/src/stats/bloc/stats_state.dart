part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

final class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.initial,
    this.monthlyTransactions = const [],
    this.incomeCategoryTotals = const [],
    this.expenseCategoryTotals = const [],
    this.showExpenses = true,
  });

  final List<Transaction> monthlyTransactions;
  final StatsStatus status;
  final List<PieChartDataObject> expenseCategoryTotals;
  final List<PieChartDataObject> incomeCategoryTotals;
  final bool showExpenses;

  StatsState copyWith({
    List<Transaction> Function()? monthlyTransactions,
    StatsStatus Function()? status,
    List<PieChartDataObject> Function()? incomeCategoryTotals,
    List<PieChartDataObject> Function()? expenseCategoryTotals,
    bool Function()? showTransactions,
  }) {
    return StatsState(
      showExpenses: showTransactions != null ? showTransactions() : this.showExpenses,
      monthlyTransactions:
          monthlyTransactions != null ? monthlyTransactions() : this.monthlyTransactions,
      status: status != null ? status() : this.status,
      incomeCategoryTotals: incomeCategoryTotals != null
          ? incomeCategoryTotals()
          : this.incomeCategoryTotals,
      expenseCategoryTotals: expenseCategoryTotals != null
          ? expenseCategoryTotals()
          : this.expenseCategoryTotals,
    );
  }

  @override
  List<Object?> get props => [
        monthlyTransactions,
        status,
        incomeCategoryTotals,
        expenseCategoryTotals,
        showExpenses
      ,];
}
