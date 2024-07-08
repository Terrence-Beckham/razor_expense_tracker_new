import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:transactions_repository/transactions_repository.dart';

import '../../edit_transaction/view/edit_transaction_view.dart';
import '../../widgets/konstants.dart';
import '../bloc/transactions_overview_bloc.dart';

class TransactionsOverviewPage extends StatelessWidget {
  const TransactionsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionsOverviewBloc(
        context.read<TransactionsRepository>(),
      )..add(const InitialDataEvent()),
      child: const TransactionsOverviewView(),
    );
  }
}

class TransactionsOverviewView extends StatelessWidget {
  const TransactionsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            'Razor Expense Tracker',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: BlocBuilder<TransactionsOverviewBloc, TransactionsOverviewState>(
          builder: (context, state) {
            switch (state.status) {
              case TransactionsOverviewStatus.initial:
                return const Center(child: Text('Initial View'));

              case TransactionsOverviewStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case TransactionsOverviewStatus.success:
                return const ExpenseOverviewSuccessView();
              case TransactionsOverviewStatus.failure:
                return Center(
                  child: Text(context.tr('somethingWentWrong'),),
                );
            }
          },
        ),
      ),
    );
  }
}

class ExpenseOverviewSuccessView extends StatelessWidget {
  const ExpenseOverviewSuccessView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionsOverviewBloc, TransactionsOverviewState>(
      listenWhen: (previous, current) =>
          previous.deletedTransaction != current.deletedTransaction &&
          current.deletedTransaction != null,
      listener: (context, state) {
        final deletedTransaction = state.deletedTransaction;
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              context.tr('transactionDeleted'),
              // 'Transaction deleted',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            action: SnackBarAction(
              label: context.tr('undo'),
              onPressed: () {
                context.read<TransactionsOverviewBloc>().add(
                      UndoDeleteTransactionEvent(deletedTransaction!),
                    );
              },
            ),
          ),
        );
      },
      builder: (context, state) {
        return Column(
          children: [
            Container(
              child: ListTile(
                title: Text(
                  context.tr('helloUser'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                // subtitle: const Text('User'),

                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(8, 8),
                          blurRadius: 15,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-8, -8),
                          blurRadius: 15,
                          spreadRadius: 1)
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.person_2_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(8, 8),
                          blurRadius: 15,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-8, -8),
                          blurRadius: 15,
                          spreadRadius: 1),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(8, 8),
                          blurRadius: 15,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-8, -8),
                          blurRadius: 15,
                          spreadRadius: 1),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(context.tr(
                          'totalBalance'),
                          // 'Total Balance',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 24),
                        ),
                      ),
                      if (state.transactions.isNotEmpty)
                        Text(
                          // r' $1,000.00',
                          '\$ ${state.balance ?? '\$'}'
                          // '\$'
                          ,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 34,
                          ),
                        )
                      else
                        const Text(r'$'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward_rounded,
                                  color: Colors.green,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      context.tr('income'),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Text(
                                      '\$ ${state.incomeTotals ?? '\$'}',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16,
                              top: 16,
                              right: 18,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_downward_rounded,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Text(
                                        context.tr('expenses'),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '\$ ${state.expenseTotals ?? '\$'}',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr('transactions'),
                    // 'transactions',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.onPrimary)),
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: state.transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return SizedBox(child: TransactionTile(expense: state.expenses[index]));
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(8, 8),
                                blurRadius: 15,
                                spreadRadius: 1),
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(-8, -8),
                                blurRadius: 15,
                                spreadRadius: 1)
                          ],
                        ),
                        height: 75,
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  context.read<TransactionsOverviewBloc>().add(
                                      DeleteTransactionEvent(
                                          state.transactions[index]));
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<EditTransactionPage>(
                                      builder: (context) => EditTransactionPage(
                                        transaction: state.transactions[index],
                                      ),
                                    ),
                                  );
                                  //
                                },
                                backgroundColor: Colors.green,
                                icon: Icons.edit,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Icon(
                              myIcons[
                                  state.transactions[index].category?.iconName],
                              color: colorMapper[state
                                  .transactions[index].category?.colorName],
                            ),
                            // leading: Icon(
                            // // myIcons(expense.iconname);
                            // Icons.abc , color: Colors.red,
                            // ),
                            title: Text(
                               context.tr('${state.transactions[index].category?.name?.toLowerCase()}') ??
                                    ' ',style: TextStyle(fontSize: 20),),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4),
                              child: Text(
                                state.transactions[index].dateOfTransaction
                                    .toString()
                                    .substring(0, 10),
                              ),
                            ),
                            trailing: Text(
                              '\$ ${state.transactions[index].amount}',
                              style: state.transactions[index].isExpense
                                  ? const TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                    )
                                  : const TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
