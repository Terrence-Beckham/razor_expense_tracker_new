import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razor_expense_tracker/src/expense_overview/bloc/expense_overview_bloc.dart';
import 'package:razor_expense_tracker/src/widgets/konstants.dart';

class ExpenseOverviewPage extends StatelessWidget {
  const ExpenseOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpenseOverviewBloc(
        context.read<ExpenseRepository>(),
      )..add(const InitialDataEvent()),
      child: const ExpenseOverviewView(),
    );
  }
}

class ExpenseOverviewView extends StatelessWidget {
  const ExpenseOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Razor Expense Tracker',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: BlocBuilder<ExpenseOverviewBloc, ExpenseOverviewState>(
          builder: (context, state) {
            switch (state.status) {
              case ExpenseOverviewStatus.initial:
                return const Center(child: Text('Initial View'));

              case ExpenseOverviewStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ExpenseOverviewStatus.success:
                return const ExpenseOverviewSuccessView();
              case ExpenseOverviewStatus.failure:
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

class ExpenseOverviewSuccessView extends StatelessWidget {
  const ExpenseOverviewSuccessView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseOverviewBloc, ExpenseOverviewState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              title: const Text('Hello Buddy'),
              subtitle: const Text('User'),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.person_2_outlined,
                  color: Colors.white,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 8,
                  shadowColor: Theme.of(context).colorScheme.primary,
                  color: Theme.of(context).colorScheme.primary,
                  child:    Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Total Balance',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),

                     if (state.expenses.isNotEmpty) Text(
                        // r' $1,000.00',
                       '\$ ${state.expenses.first.amount?? '\$'}'
                     // '\$'
                       ,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                        ),
                      ) else const Text(r'$'),
                      const Row(
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
                                      'Income',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      r' $1,000',
                                      style: TextStyle(
                                        color: Colors.white,
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
                                        'Expenses',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        r' $1,000',
                                        style: TextStyle(
                                          color: Colors.white,
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
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'Transactions',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      'view all',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: state.expenses.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return SizedBox(child: TransactionTile(expense: state.expenses[index]));
                      return SizedBox(
                        height: 75,
                        child: Card(
                          child: ListTile(
                            leading: Icon(
                              myIcons[state.expenses[index].category.iconName],
                              color: colorMapper[
                                  state.expenses[index].category.colorName],
                            ),
                            // leading: Icon(
                            // // myIcons(expense.iconname);
                            // Icons.abc , color: Colors.red,
                            // ),
                            title: Text(
                                state.expenses[index].category.name.toString()),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4),
                              child: Text(
                                state.expenses[index].dateOfTransaction
                                    .toString()
                                    .substring(0, 10),
                              ),
                            ),
                            trailing: Text(
                              '\$ ${state.expenses[index].amount}',
                              style: state.expenses[index].isExpense
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
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
