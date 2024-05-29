import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  AddTransactionBloc(this._transactionsRepository) : super(const AddTransactionState()) {
    on<Initial>(_onInitial);
    on<AddExpense>(_onAddExpense);
  }
final TransactionsRepository _transactionsRepository;
  FutureOr<void> _onInitial(Initial event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(status: () => AddTransactionStatus.loading));
  }

  FutureOr<void> _onAddExpense(AddExpense event, Emitter<AddTransactionState> emit) {
    _transactionsRepository.saveTransaction(event.expense);
  }
}
