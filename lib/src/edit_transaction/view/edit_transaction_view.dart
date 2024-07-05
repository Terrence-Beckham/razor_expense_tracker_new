import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:razor_expense_tracker_new/src/edit_transaction/edit_transaction_bloc.dart';
import 'package:razor_expense_tracker_new/src/widgets/konstants.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

class EditTransactionPage extends StatelessWidget {
  const EditTransactionPage({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditTransactionBloc(
          transactionsRepository: context.read<TransactionsRepository>(),
          transaction: transaction)
        ..add(InitialDataEvent()),
      child: EditTransactionView(),
    );
  }
}

class EditTransactionView extends StatelessWidget {
  EditTransactionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Edit Transaction'),
        ),
        body: BlocBuilder<EditTransactionBloc, EditTransactionState>(
          builder: (context, state) {
            switch (state.status) {
              case EditTransactionStatus.initial:
                return const Center(child: Text('Initial View'));

              case EditTransactionStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case EditTransactionStatus.success:
                return EditTransactionSuccessView();
              case EditTransactionStatus.failure:
                return const Center(
                  child: Text('Somethig went wrong'),
                );
            }
          },
        ),
      ),
    );
  }
}

class EditTransactionSuccessView extends StatelessWidget {
  EditTransactionSuccessView({super.key}) : _logger = Logger();
  final Logger _logger;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionBloc, EditTransactionState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(
                    myIcons[state.transaction.category?.iconName],
                    color: colorMapper[state.transaction.category?.colorName],
                  ),
                ),
              ),
              SizedBox(height: 16),

              //Expense Display
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    initialValue: state.transaction.amount.toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      try {
                        // code that may cause an exception
                        context.read<EditTransactionBloc>().add(
                              UpdateTransactionAmount(
                                state.transaction,
                                int.parse(value),
                              ),
                            );
                        context.read<EditTransactionBloc>().add(
                              TransactionAmountError(false),
                            );
                      } catch (e) {
                        // code that handles the exception
                        context.read<EditTransactionBloc>().add(
                              TransactionAmountError(true),
                            );
                        _logger.e(e);
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: state.transaction.isExpense
                          ? const Icon(
                              Icons.money,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.money,
                              color: Colors.green,
                            ),
                      filled: true,
                      fillColor: Colors.blueGrey,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              state.amountDisplayError
                  ? Text(
                      'Only numbers are allowed in this field',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    )
                  : Container(),
              const SizedBox(
                height: 24,
              ),

              //Category DropDown
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    onTap: () => {},
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: state.transaction.category?.name,
                      // hintText: state.isCategorySelected
                      //     ? state.tempCategory.name
                      //     : 'Category',
                      prefixIcon: Icon(
                        myIcons[
                            state.transaction.category?.iconName.toString()],
                        color:
                            colorMapper[state.transaction.category?.colorName],
                      ),

                      suffixIcon: IconButton(
                        icon: const Icon(Symbols.add),
                        onPressed: () {
                          context.read<EditTransactionBloc>().add(
                                IsCategoryExpandedUpdated(),
                              );
                        },
                        color: Colors.white,
                      ),
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      filled: true,
                      fillColor: Colors.blueGrey,
                      border: state.isCategoryExpanded
                          ? const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            )
                          : OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                    ),
                  ),
                ),
              ),

              state.isCategoryExpanded
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        width: double.infinity,
                        height: 300,
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 50),
                              height: 250,
                              child: GridView.builder(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                ),
                                shrinkWrap: true,
                                itemCount: state.categories.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4)),
                                itemBuilder: (context, int index) {
                                  return InputChip(
                                    backgroundColor: colorMapper[
                                        state.categories[index].colorName],
                                    avatar: Icon(
                                      myIcons[state.categories[index].iconName
                                          .toString()],
                                    ),
                                    label: Text(
                                      state.categories[index].name.toString(),
                                      style: const TextStyle(
                                          color: Colors.black87),
                                    ),
                                    onPressed: () {
                                      context.read<EditTransactionBloc>().add(
                                            TempCategoryUpdated(
                                              state.categories[index],
                                            ),
                                          );
                                      context
                                          .read<EditTransactionBloc>()
                                          .add(IsCategoryExpandedUpdated());
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),

//Date FormField and picker

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    onChanged: (value) => {},
                    // context
                    //     .read<AddTransactionBloc>()
                    //     .add(UpdateDateTextField(value)),

                    onTap: () => buildShowDatePicker(context),
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      // hintText: state.transaction.dateOfTransaction.toString().substring(0, 10),
                      hintText: state.tempDate.toString().substring(0, 10),
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      prefixIcon: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.blueGrey,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Update Transaction',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> buildShowDatePicker(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime.now().add(const Duration(days: 365)),
  );
  if (picked != null) {
    // context.read<AddTransactionBloc>().add(UpdateTempDate(picked));
    //
    // context
    //     .read<AddTransactionBloc>()
    //     .add(UpdateDateTextField(picked.toString().substring(0, 10)));
    // context.read<AddTransactionBloc>().add(UpdateIsDateChoosen(true));
  }
}
