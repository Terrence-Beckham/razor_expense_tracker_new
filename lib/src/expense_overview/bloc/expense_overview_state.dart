part of 'expense_overview_bloc.dart';

enum ExpenseOverviewStatus { initial, loading, success, failure }

final class ExpenseOverviewState extends Equatable {
  const ExpenseOverviewState({
    this.status = ExpenseOverviewStatus.success,
    this.expenses = const [],
  });

  final ExpenseOverviewStatus status;
  final List<Expense> expenses;

  ExpenseOverviewState copyWith({
    ExpenseOverviewStatus Function()? status,
    List<Expense> Function()? expenses,
  }) {
    return ExpenseOverviewState(
      status: status != null ? status() : this.status,
      expenses: expenses != null ? expenses() : this.expenses,
    );
  }

  @override
  List<Object?> get props => [status, expenses];
}
