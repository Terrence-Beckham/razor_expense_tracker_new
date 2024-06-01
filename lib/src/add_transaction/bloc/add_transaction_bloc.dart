import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  AddTransactionBloc(this._transactionsRepository)
      : super(AddTransactionState.empty()) {
    on<Initial>(_onInitial);
    on<AddTransaction>(onAddTransaction);
    on<UpdateSelectedIcon>(_onUpdateSelectedIcon);
    on<UpdateSelectedColor>(_onUpdateSelectedColor);
    on<UpdateSelectedCategory>(_onUpdateSelectedCategory);
    on<UpdateIsExpense>(_onUpdateIsExpense);
    on<UpdateIsIncome>(_onUpdateIsIncome);
    on<UpdateIsCategoryExpanded>(_onUpdateIsCategoryExpanded);
    on<UpdateIsCategorySelected>(_onUpdateIsCategorySelected);
    on<UpdateTempCategory>(_onUpdateTempCategory);
    on<UpdateDateTextController>(_onUpdateDateTextController);
    on<UpdateTransactionAmountField>(_onUpdateTransactionAmountField);
    on<UpdateIsDateChoosen>(_onUpdateIsDateChoosen);
    // on<UpdateTempDate>(_onUpdateTempDate);
    on<UpdateTempTransaction>(_onUpdateTempTransaction);
    on<UpdateStatus>(_onUpdateStatus);
    on<UpdateCategories>(_onUpdateCategories);
  }

  final TransactionsRepository _transactionsRepository;

  FutureOr<void> _onInitial(
      Initial event, Emitter<AddTransactionState> emit) async {
    emit(state.copyWith(status: () => AddTransactionStatus.loading));
    await emit.forEach<List<TransactionCategory>>(
      _transactionsRepository.getTransactionCategories(),
      onData: (category) => state.copyWith(
          status: () => AddTransactionStatus.success,
          categories: () => category),
    );
  }

  FutureOr<void> onAddTransaction(
      AddTransaction event, Emitter<AddTransactionState> emit) {
    _transactionsRepository.saveTransaction(event.transaction);
  }

  FutureOr<void> _onUpdateSelectedIcon(
      UpdateSelectedIcon event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        selectedIcon: () => event.icon));
  }

  FutureOr<void> _onUpdateSelectedColor(event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        selectedColor: () => event.color));
  }



  FutureOr<void> _onUpdateSelectedCategory(UpdateSelectedCategory event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        tempCategory: () => event.category));
  }
  FutureOr<void> _onUpdateIsExpense(UpdateIsExpense event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isExpense: () => event.isExpense));
  }

  FutureOr<void> _onUpdateIsIncome(UpdateIsIncome event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isIncome: () => event.isIncome));
  }

  FutureOr<void> _onUpdateIsCategoryExpanded(UpdateIsCategoryExpanded event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isCategoryExpanded: () => event.isCategoryExpanded));
  }

  FutureOr<void> _onUpdateIsCategorySelected(UpdateIsCategorySelected event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isCategorySelected: () => event.isCategorySelected));
  }

  FutureOr<void> _onUpdateTempCategory(UpdateTempCategory event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        tempCategory: () => event.category));
  }

  FutureOr<void> _onUpdateDateTextController(UpdateDateTextController event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        dateTextController: () => event.dateTextController));
  }

  FutureOr<void> _onUpdateTransactionAmountField(UpdateTransactionAmountField event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        transactionAmountController: () => event.transactionAmount));
  }

  FutureOr<void> _onUpdateIsDateChoosen(UpdateIsDateChoosen event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isDateChoosen: () => event.isDateChoosen));
  }

  // FutureOr<void> _onUpdateTempDate(UpdateTempDate event, Emitter<AddTransactionState> emit) {
  //   emit(state.copyWith(
  //       status: () => AddTransactionStatus.success,
  //       // tempDate: () => event.tempDate));
  // }

  FutureOr<void> _onUpdateTempTransaction(UpdateTempTransaction event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        tempTransaction: () => event.tempTransaction));
  }

  FutureOr<void> _onUpdateStatus(UpdateStatus event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => event.status));
  }

  FutureOr<void> _onUpdateCategories(UpdateCategories event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        categories: () => event.categories));
  }
}
