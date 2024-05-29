import 'package:expense_api/expense_api.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:razor_expense_tracker/src/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:razor_expense_tracker/src/widgets/konstants.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTransactionBloc(context.read<ExpenseRepository>()),
      child: const AddTransactionView(),
    );
  }
}

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({
    super.key,
  });

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  final Logger _logger = Logger();
  var tempExpense = Expense(
    timestamp: DateTime.now(),
    amount: 0,
    category: TransactionCategory(),
    dateOfTransaction: DateTime.now(),
    description: '',
    note: '',
    isExpense: false,
    isIncome: false,
  );

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
                  return const AddTransactionSuccessView();
                // return const Center(child: Text('Initial Screen'),);
                case AddTransactionStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case AddTransactionStatus.success:
                  return const AddTransactionSuccessView();
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

class AddTransactionSuccessView extends StatefulWidget {
  const AddTransactionSuccessView({super.key});

  @override
  State<AddTransactionSuccessView> createState() =>
      _AddTransactionSuccessViewState();
}

class _AddTransactionSuccessViewState extends State<AddTransactionSuccessView> {
  final _logger = Logger();

  Icon selectedIcon = const Icon(CupertinoIcons.chevron_forward);
  Color selectedColor = Colors.blue;
  String selectedTransactionType = 'expense';
  bool isExpense = true;
  bool isIncome = false;
  bool isCategoryExpanded = false;
  bool isCategorySelected = false;
  var _tempCategory = TransactionCategory();
  final _dateTextController = TextEditingController();
  final _transactionAmountController = TextEditingController();
  bool isDateChoosen = false;
  late DateTime _tempDate;
  final Expense _tempExpense = Expense(
    timestamp: DateTime.now(),
    amount: 0,
    category: TransactionCategory(),
    dateOfTransaction: DateTime.now(),
    description: '',
    note: '',
    isExpense: true,
    isIncome: false,
  );

  @override
  void dispose() {
    super.dispose();
    _dateTextController.dispose();
    _transactionAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              OutlinedButton(
                onPressed: () {
                  // Handle button press
                  setState(() {
                    isIncome = false;
                    isExpense = true;
                    _logger.d('Is Income = $isIncome,  IsExpense: $isExpense');
                  });
                },
                style: isExpense
                    ? OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.green,
                          // Border color when button is not pressed
                          width: 4, // Border width when button is not pressed
                        ),
                      )
                    : OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.white,
                          // Border color when button is not pressed
                          width: 4, // Border width when button is not pressed
                        ),
                      ),
                child: const Text('Expense'),
              ),
              OutlinedButton(
                onPressed: () {
                  // Handle button press
                  setState(() {
                    isIncome = true;
                    isExpense = false;
                    _logger.d('Is Income = $isIncome,  IsExpense: $isExpense');
                  });
                },
                style: isIncome
                    ? OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.green,
                          // Border color when button is not pressed
                          width: 4, // Border width when button is not pressed
                        ),
                      )
                    : OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.white,
                          // Border color when button is not pressed
                          width: 4, // Border width when button is not pressed
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
                controller: _transactionAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: isExpense
                      ? const Icon(
                          FontAwesomeIcons.dollarSign,
                          color: Colors.red,
                        )
                      : const Icon(
                          FontAwesomeIcons.dollarSign,
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
              child: buildCategoryFormField(),
            ),
          ),

          if (isCategoryExpanded)
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
                        itemCount: defaultCategory.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, int index) {
                          _logger.d(defaultCategory[index]);
                          return InputChip(
                            backgroundColor:
                                colorMapper[defaultCategory[index].colorName],
                            avatar: Icon(
                              myIcons[
                                  defaultCategory[index].iconName.toString()],
                            ),
                            label: Text(
                              defaultCategory[index].name.toString(),
                              style: const TextStyle(color: Colors.black87),
                            ),
                            onPressed: () {
                              setState(() {
                                _tempCategory = TransactionCategory()
                                  ..colorName = defaultCategory[index].colorName
                                  ..name = defaultCategory[index].name
                                  ..iconName = defaultCategory[index].iconName;
                                _logger.e(_tempCategory);
                                isCategorySelected = true;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _showAddNewCategoryPicker,
                      icon: const Icon(Symbols.add),
                      label: const Text('Add a New Category'),
                    ),
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
                onTap: () => buildShowDatePicker(context),
                readOnly: true,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: !isDateChoosen ? 'Date' : _dateTextController.text,
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
                  if (isIncome) {
                    final newExpense = _tempExpense.copyWith(
                      timestamp: DateTime.now(),
                      amount: int.parse(_transactionAmountController.text),
                      category: _tempCategory,
                      dateOfTransaction: _tempDate,
                      description: '',
                      note: '',
                      isExpense: false,
                      isIncome: true,
                    );
                    _logger.d(
                      'This is the temporary Expense object: $newExpense',
                    );
                    context
                    ///Todo Why am I using my Bloc like a Cubit
                    ///?//
                        .read<AddTransactionBloc>()
                        .add(AddExpense(newExpense));
                    Navigator.of(context).pop();
                  } else {
                    final newExpense = _tempExpense.copyWith(
                      timestamp: DateTime.now(),
                      amount: int.parse(_transactionAmountController.text),
                      category: _tempCategory,
                      dateOfTransaction: _tempDate,
                      description: '',
                      note: '',
                      isExpense: true,
                      isIncome: false,
                    );
                    context
                        .read<AddTransactionBloc>()
                        .add(AddExpense(newExpense));
                    Navigator.of(context).pop();
                    _logger.d(
                      'This is the temporary Expense object: $newExpense',
                    );
                  }
                },
                child: isExpense
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
  }

  Future<void> buildShowDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _dateTextController.text = picked.toString().substring(0, 10);
        _tempDate = picked;
        isDateChoosen = true;
      });
    }
  }

  TextFormField buildCategoryFormField() {
    return TextFormField(
      onTap: () => setState(() {
        isCategoryExpanded = !isCategoryExpanded;
      }),
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: !isCategorySelected ? 'Category' : _tempCategory.name,
        prefixIcon: !isCategorySelected
            ? const Icon(
                Icons.category,
                color: Colors.white,
              )
            : Icon(
                myIcons[_tempCategory.iconName],
                color: Colors.white,
              ),
        suffixIcon: IconButton(
          icon: const Icon(FontAwesomeIcons.plus),
          onPressed: () {
            setState(() {
              isCategoryExpanded = !isCategoryExpanded;
            });
          },
          color: Colors.white,
        ),
        hintStyle: const TextStyle(color: Colors.white, fontSize: 20),
        filled: true,
        fillColor: Colors.blueGrey,
        border: isCategoryExpanded
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
    );
  }

  Future<void> _showAddNewCategoryPicker() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var isCategoryExpanded = false;
        var isColorExpanded = false;
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
                        suffixIcon: const Icon(FontAwesomeIcons.plus),
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
                        setState(() {
                          isCategoryExpanded = !isCategoryExpanded;
                          isColorExpanded = false;
                        });
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
                          child: selectedIcon,
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
                        border: isCategoryExpanded
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
                    if (isCategoryExpanded)
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
                            itemCount: categoryWidgets.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, int i) {
                              return GestureDetector(
                                onTap: () => setState(() {
                                  selectedIcon = categoryWidgets[i];
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 8,
                                      color: selectedIcon == categoryWidgets[i]
                                          ? Colors.green
                                          : Colors.blueGrey,
                                    ),
                                  ),
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
                        setState(() {
                          isColorExpanded = !isColorExpanded;
                          isCategoryExpanded = false;
                        });
                      },
                      readOnly: true,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Color',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        suffixIcon: isColorExpanded
                            ? const Icon(
                                CupertinoIcons.chevron_down,
                                color: Colors.white,
                              )
                            : const Icon(
                                CupertinoIcons.chevron_forward,
                                color: Colors.white,
                              ),
                        filled: true,
                        fillColor: selectedColor,
                        border: isColorExpanded
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
                    if (isColorExpanded)
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
                                onTap: () => setState(() {
                                  selectedColor = colorPickerWidgets[i];
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 6,
                                      color:
                                          selectedColor == colorPickerWidgets[i]
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
  }
}

