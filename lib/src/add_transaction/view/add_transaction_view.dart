import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:razor_expense_tracker_new/src/stats/bloc/stats_bloc.dart';
import 'package:razor_expense_tracker_new/src/transactions_overview/bloc/transactions_overview_bloc.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

import '../../widgets/konstants.dart';
import '../bloc/add_transaction_bloc.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddTransactionBloc>(
          create: (_) =>
              AddTransactionBloc(context.read<TransactionsRepository>())
                ..add(
                  Initial(),
                ),
        ),
        BlocProvider<TransactionsOverviewBloc>(
          create: (_) => TransactionsOverviewBloc(
            context.read<TransactionsRepository>(),
          ),
        ),
        BlocProvider<StatsBloc>(
          create: (_) => StatsBloc(context.read<TransactionsRepository>()),
        ),
      ],
      child: AddTransactionView(),
    );
  }
}

class AddTransactionView extends StatelessWidget {
  AddTransactionView({
    super.key,
  });

  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(),
          body: BlocConsumer<AddTransactionBloc, AddTransactionState>(
            listener: (BuildContext context, AddTransactionState state) {
              switch (state.status) {
                case AddTransactionStatus.addNewCategory:
                  _showAddNewCategoryPicker(context);
                default:
                  _logger.d('This is the default case');
              }
            },
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
                  return Center(
                    child: Text(
                      context.tr('somethingWentWrong'),
                    ),
                  );
                case AddTransactionStatus.addNewCategory:
                // TODO: Handle this case.
                case AddTransactionStatus.chooseCategory:
                  // TODO: Handle this case.
                  return Container();
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
        return SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    context.tr('addTransaction'),
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
                              color: Colors.red,
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
                    child: Text(
                      context.tr('expenses'),
                      style: TextStyle(fontSize: 16),
                    ),
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
                    child: Text(
                      context.tr('income'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),

              //Expense Display
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    // controller: _transactionAmountController,
                    onChanged: (value) {
                      context.read<AddTransactionBloc>().add(
                            ValidateAmountValue(value),
                          );
                    },

                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: state.isExpense
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
              state.amountValidator.hasError
                  ? Text(
                      '${state.amountValidator.errorMessage}',
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
                    style: TextStyle(fontSize: 18),
                    onTap: () => context.read<AddTransactionBloc>().add(
                        UpdateIsCategoryExpanded(!state.isCategoryExpanded)),
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: state.isCategorySelected
                          ? context
                              .tr('${state.tempCategory.name?.toLowerCase()}')
                          : context.tr('category'),
                      prefixIcon: state.isCategorySelected
                          ? Icon(
                              myIcons[state.tempCategory.iconName.toString()],
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.category,
                              color: Colors.white,
                            ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.edit),
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
              (state.isCategoryUnselected)
                  ? Text(
                      context.tr('pleaseEnterACategory'),
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    )
                  : Container(),
              if (state.isCategoryExpanded)
                Padding(
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
                                        (MediaQuery.of(context).size.height /
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
                                            !state.isCategorySelected),
                                      );
                                  context.read<AddTransactionBloc>().add(
                                        CategoryNotSelected(),
                                      );
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
                      ],
                    ),
                  ),
                )
              else
                Container(),

//Date FormField and picker
              state.isCategoryExpanded
                  ? ElevatedButton(
                      onPressed: () {
                        _showAddNewCategoryPicker(context);
                      },
                      child: Text(
                        context.tr('addANewCategory'),
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    child: TextFormField(
                      onChanged: (value) => context
                          .read<AddTransactionBloc>()
                          .add(UpdateDateTextField(value)),
                      onTap: () => buildShowDatePicker(context),
                      readOnly: true,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: !state.isDateChosen
                            ? context.tr('date')
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
                      if (state.amountValidator.hasError == true ||
                          state.transactionAmount == '') {
                        return;
                      } else if (state.tempCategory.id == null) {
                        _logger.d(
                            'No category has been selected ${state.tempCategory}');
                        context
                            .read<AddTransactionBloc>()
                            .add(CategoryNotSelected());
                        return;
                      } else if (state.isIncome) {
                        //Convert the Stored Category object to a TransactionCategory
                        final transactionCategory = TransactionCategory()
                          ..name = state.tempCategory.name
                          ..colorName = state.tempCategory.colorName
                          ..iconName = state.tempCategory.iconName;

                        final newTransaction = Transaction()
                          ..timestamp = DateTime.now()
                          ..amount = int.parse(state.transactionAmount)
                          ..dateOfTransaction = state.tempDate
                          ..description = ''
                          ..note = ''
                          ..isExpense = false
                          ..isIncome = true
                          ..category = transactionCategory;
                        //Add the new transaction to the DB
                        context
                            .read<AddTransactionBloc>()
                            .add(AddTransaction(newTransaction));
                        // context.read<TransactionsOverviewBloc>().add(InitialDataEvent());

                        Navigator.of(context).pop();
                      } else {
                        //Convert the Stored Category object to a TransactionCategory
                        final transactionCategory = TransactionCategory()
                          ..name = state.tempCategory.name
                          ..colorName = state.tempCategory.colorName
                          ..iconName = state.tempCategory.iconName;
                        final newTransaction = Transaction()
                          ..timestamp = DateTime.now()
                          ..amount = int.parse(state.transactionAmount)
                          ..dateOfTransaction = state.tempDate
                          ..description = ''
                          ..note = ''
                          ..isExpense = true
                          ..isIncome = false
                          ..category = transactionCategory;

                        _logger.d(
                          'This is the temporary Expense object: $newTransaction',
                        );
                        //Add the new transaction to the DB
                        context
                            .read<AddTransactionBloc>()
                            .add(AddTransaction(newTransaction));
                        // context
                        //     .read<TransactionsOverviewBloc>()
                        //     .add(InitialDataEvent());
                        Navigator.of(context).pop();
                      }
                    },
                    child: state.isExpense
                        ?  Text(
                            context.tr('saveExpense'),
                            style: TextStyle(fontSize: 24),
                          )
                        :  Text(
                            context.tr('saveIncome'),
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

Future<void> _showAddNewCategoryPicker(BuildContext context) async {
  final _logger = Logger();
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (innerContext) => BlocProvider.value(
          value: context.read<AddTransactionBloc>(),
          child: BlocBuilder<AddTransactionBloc, AddTransactionState>(
            builder: (context, state) {
              return SizedBox(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                    ),
                    const TextField(
                      readOnly: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        label: Text(
                          'Add Your Own Category',
                          style: TextStyle(fontSize: 32),
                        ),
                        // hintText: 'Choose A Category',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      onChanged: (value) => context
                          .read<AddTransactionBloc>()
                          .add(UpdateTempCustomCategoryName(value)),
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

                    ///Icon Picker FormField
                    TextFormField(
                      onTap: () {
                        context
                            .read<AddTransactionBloc>()
                            .add(ExpandNewIconPicker());

                        ///todo this has to be fixed in order to collapse the color picker
                        if (state.isAddNewCategoryColorPickerExpanded) {
                          context
                              .read<AddTransactionBloc>()
                              .add(ExpandNewColorPicker());
                        }
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
                        border: state.isAddNewCategoryExpanded
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
                    if (state.isAddNewCategoryExpanded)
                      Expanded(
                        child: Container(
                          height: 300,
                          decoration:
                              BoxDecoration(color: Colors.lightBlueAccent
                                  // color: Theme.of(context).primaryColor,
                                  ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: GridView.builder(
                              itemCount: state.categoryWidgetIcons.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              4)),
                              itemBuilder: (context, int i) {
                                return GestureDetector(
                                  onTap: () => {
                                    _logger.d(
                                        'This is the icon that was selected: ${state.categoryWidgetIcons[i]}'),
                                    context.read<AddTransactionBloc>().add(
                                        UpdateCustomCategoryIcon(
                                            state.categoryWidgetIcons[i]))
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 8,
                                        color: state.selectedIcon ==
                                                state.categoryWidgetIcons[i]
                                            ? Colors.green
                                            : Colors.blueGrey,
                                      ),
                                    ),

                                    ///Todo there is something wrong here.
                                    child: state.categoryWidgetIcons[i],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    else
                      Container(),
                    const SizedBox(
                      height: 16,
                    ),

                    ///Color Picker FormField
                    TextFormField(
                      onTap: () {
                        context
                            .read<AddTransactionBloc>()
                            .add(ExpandNewColorPicker());

                        ///Closes the icon picker if it is open.
                        ///todo this has to be named better. It's confusing.
                        if (state.isAddNewCategoryExpanded) {
                          context
                              .read<AddTransactionBloc>()
                              .add(ExpandNewIconPicker());
                        }
                      },
                      readOnly: true,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Color',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        suffixIcon: state.isAddNewCategoryColorPickerExpanded
                            ? const Icon(
                                CupertinoIcons.chevron_down,
                                color: Colors.white,
                              )
                            : const Icon(
                                CupertinoIcons.chevron_forward,
                                color: Colors.white,
                              ),
                        filled: true,

                        ///Todo this needs to be rewritten the fill color
                        fillColor: state.selectedColor,
                        border: state.isAddNewCategoryColorPickerExpanded
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
                    if (state.isAddNewCategoryColorPickerExpanded)
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
                              crossAxisCount: 4,
                            ),
                            itemBuilder: (context, int i) {
                              return GestureDetector(
                                onTap: () =>
                                    context.read<AddTransactionBloc>().add(
                                          UpdateNewCategoryColor(
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
                        backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.onTertiary,
                        ),
                      ),
                      onPressed: () {
                        context.read<AddTransactionBloc>().add(
                              AddNewCategory(state.tempCategory),
                            );
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
          )));
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
