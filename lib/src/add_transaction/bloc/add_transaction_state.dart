part of 'add_transaction_bloc.dart';

enum AddTransactionStatus { initial, loading, success, failure }

class AddTransactionState extends Equatable {
const  AddTransactionState({
    this.status = AddTransactionStatus.initial,
  });

  final AddTransactionStatus status;

  AddTransactionState copyWith({
    AddTransactionStatus Function()? status,
  }) {
    return AddTransactionState(
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object> get props => [status];

}
