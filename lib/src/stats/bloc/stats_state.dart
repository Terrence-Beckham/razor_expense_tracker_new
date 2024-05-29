part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

final class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.initial,
    this.monthlyExpenses = const [],
    this.incomeCategoryTotals = const [],
    this.expenseCategoryTotals = const [],
    this.showExpenses = true,
  });

  final List<Expense> monthlyExpenses;
  final StatsStatus status;
  final List<PieChartDataObject> expenseCategoryTotals;
  final List<PieChartDataObject> incomeCategoryTotals;
  final bool showExpenses;

  StatsState copyWith({
    List<Expense> Function()? monthlyExpenses,
    StatsStatus Function()? status,
    List<PieChartDataObject> Function()? incomeCategoryTotals,
    List<PieChartDataObject> Function()? expenseCategoryTotals,
    bool Function()? showExpenses,
  }) {
    return StatsState(
      showExpenses: showExpenses != null ? showExpenses() : this.showExpenses,
      monthlyExpenses:
          monthlyExpenses != null ? monthlyExpenses() : this.monthlyExpenses,
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
        monthlyExpenses,
        status,
        incomeCategoryTotals,
        expenseCategoryTotals,
        showExpenses
      ,];
}
