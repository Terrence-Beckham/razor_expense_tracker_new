import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:logger/logger.dart';

part 'expense_overview_event.dart';
part 'expense_overview_state.dart';

class ExpenseOverviewBloc
    extends Bloc<ExpenseOverviewEvent, ExpenseOverviewState> {
  ExpenseOverviewBloc(
    this._expenseRepository,
  ) : super(const ExpenseOverviewState()) {
    on<ExpenseOverviewEvent>((event, emit) {});
    on<InitialDataEvent>(_loadInitialData);
  }

  final ExpenseRepository _expenseRepository;

  late final Logger _logger;

  FutureOr<void> _loadInitialData(
    InitialDataEvent event,
    Emitter<ExpenseOverviewState> emit,
  ) async {
    await emit.forEach<List<Expense>>(
      _expenseRepository.getExpenses(),
      onData: (expense) => state.copyWith(
        status: () => ExpenseOverviewStatus.success,
        expenses: () => expense
            .reversed.toList(),
      ),
    );

    _logger = Logger();
    _logger
        .d('This is the list of expenses store in the db: ${state.expenses}');
  }
}
