import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_stats_event.dart';
part 'temp_stats_state.dart';

class TempStatsBloc extends Bloc<TempStatsEvent, TempStatsState> {
  TempStatsBloc() : super(TempStatsInitial()) {
    on<TempStatsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
