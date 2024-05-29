part of 'expense_overview_bloc.dart';

abstract class ExpenseOverviewEvent extends Equatable {
  const ExpenseOverviewEvent();
}

final class InitialDataEvent extends ExpenseOverviewEvent{
  const InitialDataEvent();

  @override
  List<Object?> get props =>[];

}
