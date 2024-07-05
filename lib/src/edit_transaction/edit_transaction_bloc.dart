import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'edit_transaction_event.dart';
part 'edit_transaction_state.dart';

class EditTransactionBloc
    extends Bloc<EditTransactionEvent, EditTransactionState> {
  EditTransactionBloc(
      {required TransactionsRepository transactionsRepository,
      required Transaction transaction})
      : _logger = Logger(),
        _transactionsRepository = transactionsRepository,
        super(
          EditTransactionState(transaction: transaction),
        ) {
    on<InitialDataEvent>(_loadInitialData);
    on<IsCategoryExpandedUpdated>(_setIsCategoryExpanded);
    on<TempCategoryUpdated>(_setTempCategory);
    on<UpdateTransactionAmount>(_updateTransactionAmount);
    on<TransactionAmountError>(_showTransactionAmountErrorMessage);
  }

  final TransactionsRepository _transactionsRepository;
  final Logger _logger;

  FutureOr<void> _loadInitialData(
      InitialDataEvent event, Emitter<EditTransactionState> emit) async {
    await emit.forEach<List<StoredCategory>>(
        _transactionsRepository.sortedCategoryStream(), onData: (categories) {
      // _logger.d('These are the categories in $categories');
      return state.copyWith(
        status: () => EditTransactionStatus.success,
        categories: () => categories,
      );
    });
  }

  FutureOr<void> _setIsCategoryExpanded(
      IsCategoryExpandedUpdated event, Emitter<EditTransactionState> emit) {
    _logger.d('is category expanded: ${state.isCategoryExpanded}');
    emit(state.copyWith(
        status: () => EditTransactionStatus.success,
        isCategoryExpanded: () => !state.isCategoryExpanded));
  }

  FutureOr<void> _setTempCategory(
      TempCategoryUpdated event, Emitter<EditTransactionState> emit) {
    _logger.e('This is the selected category: ${event.category} that was sent');
    final tempCategory = TransactionCategory()
      ..colorName = event.category.colorName
      ..iconName = event.category.iconName
      ..name = event.category.name
      ..iconCodePoint = null
      ..totalAmount = 0;
    final transaction = state.transaction;
    transaction.category = tempCategory;
    emit(
      state.copyWith(
          status: () => EditTransactionStatus.success,
          transaction: () => transaction),
    );

    _logger.f('This is the updateCategory ${state.transaction}');
  }

  FutureOr<void> _updateTransactionAmount(
      UpdateTransactionAmount event, Emitter<EditTransactionState> emit) {
    final newTransaction = event.transaction;
    newTransaction.amount = event.amount;
    emit(
      state.copyWith(
          status: () => EditTransactionStatus.success,
          transaction: () => newTransaction),
    );
    _logger.d('This is the new transaction value ${state.transaction.amount}');
  }

  FutureOr<void> _showTransactionAmountErrorMessage(
      TransactionAmountError event, Emitter<EditTransactionState> emit) {
    emit(
      state.copyWith(
          status: () => EditTransactionStatus.success,
          amountDisplayError: () => event.isError),
    );
  }
}
