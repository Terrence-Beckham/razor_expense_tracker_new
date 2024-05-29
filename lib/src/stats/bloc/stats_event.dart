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

final class LoadIncomeDataEvent extends StatsEvent {
  const LoadIncomeDataEvent();

  @override
  List<Object?> get props => [];
}

final class DisplayIncomePieChartStats extends StatsEvent {

}

final class DisplayExpensePieChartStats extends StatsEvent {

}
