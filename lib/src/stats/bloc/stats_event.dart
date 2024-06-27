part of 'stats_bloc.dart';

final class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object?> get props => [];
}

final class StatsInitialEvent extends StatsEvent {
  const StatsInitialEvent();

  @override
  List<Object?> get props => [];
}

final class PieChartSectionEvent extends StatsEvent {
  const PieChartSectionEvent();

  @override
  List<Object?> get props => [];
}

final class SubscribedToCategoryAmountsEvent extends StatsEvent {
  const SubscribedToCategoryAmountsEvent();

  @override
  List<Object?> get props => [];
}

final class DisplayIncomePieChartStats extends StatsEvent {

}

final class DisplayExpensePieChartStats extends StatsEvent {

}

final class LoadedCategoryAmountsEvent extends StatsEvent {
  const LoadedCategoryAmountsEvent();

  @override
  List<Object?> get props => [];
}

final class SetTransactionCategoryType extends StatsEvent {
  const SetTransactionCategoryType();

  @override
  List<Object?> get props => [];


}
final class IncomeDisplayRequested extends StatsEvent {
  const IncomeDisplayRequested();

  @override
  List<Object?> get props => [];
}

final class ExpenseDisplayRequested extends StatsEvent {
  const ExpenseDisplayRequested();

  @override
  List<Object?> get props => [];
}

final class DatePeriodChosenEvent extends StatsEvent {
  const DatePeriodChosenEvent(this.datePeriodChosen);
final DatePeriodChosen datePeriodChosen;
  @override
  List<Object?> get props => [datePeriodChosen];
}