part of 'temp_stats_bloc.dart';

sealed class TempStatsState extends Equatable {
  const TempStatsState();
}

final class TempStatsInitial extends TempStatsState {
  @override
  List<Object> get props => [];
}
