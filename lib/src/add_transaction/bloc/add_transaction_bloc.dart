import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:razor_expense_tracker_new/src/widgets/konstants.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  AddTransactionBloc(this._transactionsRepository)
      : super(AddTransactionState.empty()) {
    on<Initial>(_onInitial);
    on<AddTransaction>(onTransactionAdded);
    on<UpdateSelectedIcon>(_onUpdateSelectedIcon);
    on<UpdateSelectedCategory>(_onUpdateSelectedCategory);
    on<UpdateIsExpense>(_onUpdateIsExpense);
    on<UpdateIsIncome>(_onUpdateIsIncome);
    on<UpdateIsCategoryExpanded>(_onUpdateIsCategoryExpanded);
    on<UpdateIsCategorySelected>(_onUpdateIsCategorySelected);
    on<UpdateDateTextField>(_onUpdateDateTextController);
    on<UpdateTransactionAmountField>(_onUpdateTransactionAmountField);
    on<UpdateIsDateChoosen>(_onUpdateIsDateChoosen);
    on<UpdateTempDate>(_onUpdateTempDate);
    on<UpdateTempTransaction>(_onUpdateTempTransaction);
    on<UpdateStatus>(_onUpdateStatus);
    on<UpdateCategories>(_onUpdateCategories);
    on<LaunchAddNewCategoryPage>(_onLaunchAddNewCategoryPage);
    on<ExpandNewIconPicker>(_onExpandNewIconPicker);
    on<ExpandNewColorPicker>(_onExpandNewColorPicker);
    on<UpdateCustomCategoryIcon>(_onUpdateCustomCategoryIcon);
    on<UpdateTempCustomCategoryName>(_onUpdateTempCategoryName);
    on<AddNewCategory>(_onAddNewCategory);
    on<UpdateTempCategory>(_onUpdateTempCategory);
    on<UpdateNewCategoryColor>(_onUpdateNewCategoryColor);
  }

  final TransactionsRepository _transactionsRepository;
  final Logger _logger = Logger();

  FutureOr<void> _onInitial(
      Initial event, Emitter<AddTransactionState> emit) async {
    final localTransactions = _transactionsRepository.streamCategories();
    _logger.d('These are the local trans from the repository');
    emit(state.copyWith(status: () => AddTransactionStatus.loading));
    await emit.forEach<List<StoredCategory>>(
      _transactionsRepository.streamCategories(),
      onData: (category) => state.copyWith(
          status: () => AddTransactionStatus.success,
          categories: () => category),
    );
  }

  FutureOr<void> onTransactionAdded(
      AddTransaction event, Emitter<AddTransactionState> emit) {
    _transactionsRepository.saveTransaction(event.transaction);
  }

  FutureOr<void> _onUpdateSelectedIcon(
      UpdateSelectedIcon event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        selectedIcon: () => event.icon));
  }

  FutureOr<void> _onUpdateNewCategoryColor(
      event, Emitter<AddTransactionState> emit) {
    final reverseColorMapper =
        colorMapper.map((key, value) => MapEntry(value, key));
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        selectedColor: () => event.color,
        newCustomCategory: () => state.newCustomCategory
          ..colorName = reverseColorMapper[event.color]));
  }

  //
  /// I can use the categoryWidgetsLookupMap.map((key, value) => MapEntry(value, key));
  FutureOr<void> _onUpdateSelectedCategory(
      UpdateSelectedCategory event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        tempCategory: () => event.category));
  }

  FutureOr<void> _onUpdateIsExpense(
      UpdateIsExpense event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isExpense: () => event.isExpense));
  }

  FutureOr<void> _onUpdateIsIncome(
      UpdateIsIncome event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isIncome: () => event.isIncome));
  }

  FutureOr<void> _onUpdateIsCategoryExpanded(
      UpdateIsCategoryExpanded event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isCategoryExpanded: () => event.isCategoryExpanded));
  }

  FutureOr<void> _onUpdateIsCategorySelected(
      UpdateIsCategorySelected event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isCategorySelected: () => event.isCategorySelected));
  }

  FutureOr<void> _onUpdateTempCategory(
      UpdateTempCategory event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        tempCategory: () => event.category));
  }

  FutureOr<void> _onUpdateDateTextController(
      UpdateDateTextField event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        dateTextField: () => event.dateTextValue));
  }

  FutureOr<void> _onUpdateTransactionAmountField(
      UpdateTransactionAmountField event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        transactionAmountController: () => event.transactionAmount));
  }

  FutureOr<void> _onUpdateIsDateChoosen(
      UpdateIsDateChoosen event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isDateChoosen: () => event.isDateChoosen));
  }

  // FutureOr<void> _onUpdateTempDate(UpdateTempDate event, Emitter<AddTransactionState> emit) {
  //   emit(state.copyWith(
  //       status: () => AddTransactionStatus.success,
  //       // tempDate: () => event.tempDate));
  // }

  FutureOr<void> _onUpdateTempTransaction(
      UpdateTempTransaction event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        tempTransaction: () => event.tempTransaction));
  }

  FutureOr<void> _onUpdateStatus(
      UpdateStatus event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(status: () => event.status));
  }

  FutureOr<void> _onUpdateCategories(
      UpdateCategories event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        categories: () => event.categories));
  }

  FutureOr<void> _onUpdateTempDate(
      UpdateTempDate event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        tempDate: () => event.tempDate));
  }

  FutureOr<void> _onLaunchAddNewCategoryPage(
      LaunchAddNewCategoryPage event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
      status: () => AddTransactionStatus.addNewCategory,
    ));
  }

  FutureOr<void> _onExpandNewIconPicker(
      ExpandNewIconPicker event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        isAddNewCategoryExpanded: () => !state.isAddNewCategoryExpanded));
  }

  FutureOr<void> _onExpandNewColorPicker(
      ExpandNewColorPicker event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(
        // status: () => AddTransactionStatus.success,
        isAddNewCategoryColorPickerExpanded: () =>
            !state.isAddNewCategoryColorPickerExpanded));
    _logger.i(
        'The color picker has been expanded its value is ${state.isAddNewCategoryColorPickerExpanded}');
  }

  _onUpdateCustomCategoryIcon(
      UpdateCustomCategoryIcon event, Emitter<AddTransactionState> emit) {
    _logger.e(event.icon);
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        newCustomCategory: () => state.newCustomCategory
          ..iconName = categoryWidgetsLookupMap[event.icon.icon]));
  }

  FutureOr<void> _onUpdateTempCategoryName(
      UpdateTempCustomCategoryName event, Emitter<AddTransactionState> emit) {
    _logger.e(event.categoryName);
    emit(state.copyWith(
        status: () => AddTransactionStatus.success,
        newCustomCategory: () =>
            state.newCustomCategory..name = event.categoryName));
  }

  FutureOr<void> _onAddNewCategory(
      AddNewCategory event, Emitter<AddTransactionState> emit) {
    _transactionsRepository.addCustomCategory(event.category);
  }
}
