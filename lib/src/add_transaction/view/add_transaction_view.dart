import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/konstants.dart';
import '../bloc/add_transaction_bloc.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTransactionBloc(context.read<TransactionsRepository>())
        ..add(Initial()),
      child: const AddTransactionView(),
    );
  }
}

class AddTransactionView extends StatelessWidget {
  const AddTransactionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<AddTransactionBloc, AddTransactionState>(
            builder: (context, state) {
              switch (state.status) {
                case AddTransactionStatus.initial:
                  return AddTransactionSuccessView();
                // return const Center(child: Text('Initial Screen'),);
                case AddTransactionStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case AddTransactionStatus.success:
                  return AddTransactionSuccessView();
                case AddTransactionStatus.failure:
                  return const Center(
                    child: Text('something went wrong'),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AddTransactionSuccessView extends StatelessWidget {
  AddTransactionSuccessView({super.key});

  final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTransactionBloc, AddTransactionState>(
      builder: (context, state) {
        _logger
          ..d('The category is expanded: ${state.isCategoryExpanded}')
          ..d('This is the list of categories ${state.categories}');

        return SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///Button to change the transaction type to Expense
                  OutlinedButton(
                    onPressed: () {
                      context
                          .read<AddTransactionBloc>()
                          .add(UpdateIsExpense(true));
                      context
                          .read<AddTransactionBloc>()
                          .add(UpdateIsIncome(false));
                    },
                    style: state.isExpense
                        ? OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.green,
                              // Border color when button is not pressed
                              width:
                                  4, // Border width when button is not pressed
                            ),
                          )
                        :

                        ///Button to change the transaction type to Income
                        OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.white,
                              // Border color when button is not pressed
                              width:
                                  4, // Border width when button is not pressed
                            ),
                          ),
                    child: const Text('Expense'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      context
                          .read<AddTransactionBloc>()
                          .add(UpdateIsExpense(false));
                      context
                          .read<AddTransactionBloc>()
                          .add(UpdateIsIncome(true));

                      // Handle button pres
                    },
                    style: state.isIncome
                        ? OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.green,
                              // Border color when button is not pressed
                              width:
                                  4, // Border width when button is not pressed
                            ),
                          )
                        : OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.white,
                              // Border color when button is not pressed
                              width:
                                  4, // Border width when button is not pressed
                            ),
                          ),
                    child: const Text('Income'),
                  ),
                ],
              ),

              //Expense Display
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    // controller: _transactionAmountController,
                    onChanged: (value) {
                      context.read<AddTransactionBloc>().add(
                            UpdateTransactionAmountField(value),
                          );
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: state.isExpense
                          ? const Icon(
                              Symbols.currency_bitcoin,
                              color: Colors.red,
                            )
                          : const Icon(
                              Symbols.currency_bitcoin,
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
              const SizedBox(
                height: 24,
              ),

              //Category DropDown
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    onTap: () => context.read<AddTransactionBloc>().add(
                        UpdateIsCategoryExpanded(!state.isCategoryExpanded)),
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: !state.isCategorySelected
                          ? 'Category'
                          : state.tempCategory.name,
                      prefixIcon: !state.isCategorySelected
                          ? const Icon(
                              Icons.category,
                              color: Colors.white,
                            )
                          : Icon(
                              myIcons[state.tempCategory.iconName.toString()],
                              color: Colors.white,
                            ),
                      suffixIcon: IconButton(
                        icon: const Icon(Symbols.add),
                        onPressed: () {
                          context.read<AddTransactionBloc>().add(
                              UpdateIsCategoryExpanded(
                                  !state.isCategoryExpanded));
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

              if (state.isCategoryExpanded)
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
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
                        SizedBox(
                          height: 250,
                          child: GridView.builder(
                            padding: const EdgeInsets.only(
                              right: 8,
                            ),
                            shrinkWrap: true,
                            itemCount: state.categories.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
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
                                  style: const TextStyle(color: Colors.black87),
                                ),
                                onPressed: () {
                                  context.read<AddTransactionBloc>().add(
                                        UpdateTempCategory(
                                          state.categories[index],
                                        ),
                                      );
                                  context.read<AddTransactionBloc>().add(
                                      UpdateIsCategoryExpanded(
                                          !state.isColorExpanded));

                                  ///Need to set the textfield to the name and icon of the category
                                  context.read<AddTransactionBloc>().add(
                                      UpdateIsCategorySelected(
                                          !state.isCategorySelected));
                                },
                              );
                            },
                          ),
                        ),
                        // ElevatedButton.icon(
                        //   onPressed: _showAddNewCategoryPicker(context),
                        //   icon: const Icon(Symbols.add),
                        //   label: const Text('Add a New Category'),
                        // ),
                        AddNewCategoryButton(
                          onPressed: () => _showAddNewCategoryPicker(context),
                        )
                      ],
                    ),
                  ),
                )
              else
                Container(),

//Date FormField and picker

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    onChanged: (value) => context
                        .read<AddTransactionBloc>()
                        .add(UpdateDateTextField(value)),
                    onTap: () => buildShowDatePicker(context),
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: !state.isDateChosen
                          ? 'Date'
                          : state.dateTextField.toString(),
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
                      if (state.isIncome) {
                        final newTransaction = Transaction()
                          ..iconName = state.tempCategory.iconName!
                          ..colorName = state.tempCategory.colorName!
                          ..categoryName = state.tempCategory.name!
                          ..identity = Uuid().v4()
                          ..timestamp = DateTime.now()
                          ..amount = int.parse(state.transactionAmount)
                          ..dateOfTransaction = state.tempDate
                          ..description = ''
                          ..note = ''
                          ..isExpense = false
                          ..isIncome = true;
                        //Add the new transaction to the DB
                        context.read<AddTransactionBloc>().add(
                            AddTransaction(newTransaction, state.tempCategory));

                        Navigator.of(context).pop();
                      } else {
                        final newTransaction = Transaction()
                          ..iconName = state.tempCategory.iconName!
                          ..colorName = state.tempCategory.colorName!
                          ..categoryName = state.tempCategory.name!
                          ..identity = Uuid().v4()
                          ..timestamp = DateTime.now()
                          ..amount = int.parse(state.transactionAmount)
                          ..dateOfTransaction = state.tempDate
                          ..description = ''
                          ..note = ''
                          ..isExpense = true
                          ..isIncome = false;

                        print(
                          'This is the temporary Expense object: $newTransaction',
                        );
                        //Add the new transaction to the DB
                        context.read<AddTransactionBloc>().add(
                            AddTransaction(newTransaction, state.tempCategory));
                        Navigator.of(context).pop();
                      }
                    },
                    child: state.isExpense
                        ? const Text(
                            'Save Expense',
                            style: TextStyle(fontSize: 24),
                          )
                        : const Text(
                            'Save Income',
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
    context.read<AddTransactionBloc>().add(UpdateTempDate(picked));

    context
        .read<AddTransactionBloc>()
        .add(UpdateDateTextField(picked.toString().substring(0, 10)));
    context.read<AddTransactionBloc>().add(UpdateIsDateChoosen(true));
  }
}

Future<void> _showAddNewCategoryPicker(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<AddTransactionBloc, AddTransactionState>(
        builder: (context, state) {
          return AlertDialog(
            content: StatefulBuilder(
              builder: (
                BuildContext context,
                void Function(void Function()) setState,
              ) {
                return SizedBox(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const TextField(
                        readOnly: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          label: Text(
                            'Choose a Category',
                            style: TextStyle(fontSize: 32),
                          ),
                          // hintText: 'Choose A Category',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          suffixIcon: const Icon(Symbols.add),
                          filled: true,
                          fillColor: Theme.of(context).primaryColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        onTap: () {
                          context.read<AddTransactionBloc>().add(
                              UpdateIsCategoryExpanded(
                                  !state.isCategoryExpanded));
                          context
                              .read<AddTransactionBloc>()
                              .add(UpdateIsColorExpanded(false));
                        },
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Icon',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: state.selectedIcon,
                          ),
                          // suffixIcon: isCategoryExpanded
                          //     ? const Icon(
                          //         CupertinoIcons.chevron_down,
                          //         color: Colors.white,
                          //       )
                          //     : const Icon(
                          //         CupertinoIcons
                          //             .chevron_forward,
                          //         color: Colors.white,
                          //       ),
                          filled: true,
                          fillColor: Theme.of(context).primaryColor,
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
                      if (state.isCategoryExpanded)
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: GridView.builder(
                              itemCount: state.categories.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, int i) {
                                return GestureDetector(
                                  onTap: () =>
                                      context.read<AddTransactionBloc>().add(
                                            UpdateTempCategory(
                                              state.categories[i],
                                            ),
                                          ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 8,
                                        color: state.selectedIcon ==
                                                state.categories[i]
                                            ? Colors.green
                                            : Colors.blueGrey,
                                      ),
                                    ),

                                    ///Todo there is something wrong here.
                                    child: categoryWidgets[i],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      else
                        Container(),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        onTap: () {
                          context.read<AddTransactionBloc>().add(
                              UpdateIsColorExpanded(!state.isColorExpanded));
                          context
                              .read<AddTransactionBloc>()
                              .add(UpdateIsCategoryExpanded(false));
                        },
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Color',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          suffixIcon: state.isColorExpanded
                              ? const Icon(
                                  CupertinoIcons.chevron_down,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  CupertinoIcons.chevron_forward,
                                  color: Colors.white,
                                ),
                          filled: true,
                          fillColor: state.selectedColor,
                          border: state.isColorExpanded
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
                      if (state.isColorExpanded)
                        SizedBox(
                          height: 200,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: GridView.builder(
                              itemCount: colorPickerWidgets.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, int i) {
                                return GestureDetector(
                                  onTap: () =>
                                      context.read<AddTransactionBloc>().add(
                                            UpdateSelectedColor(
                                              colorPickerWidgets[i],
                                            ),
                                          ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 6,
                                        color: state.selectedColor ==
                                                colorPickerWidgets[i]
                                            ? Colors.green
                                            : Colors.blueGrey,
                                      ),
                                    ),
                                    child: ColoredBox(
                                      color: colorPickerWidgets[i],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      else
                        Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Save New Category',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}

class AddNewCategoryButton extends StatelessWidget {
  final Function onPressed;

  AddNewCategoryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => onPressed(),
      icon: const Icon(Symbols.add),
      label: const Text('Add a New Category'),
    );
  }
}
