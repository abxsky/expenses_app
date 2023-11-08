import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});
  final List<Expense> expenseData = [
    Expense(
        title: 'Perfume Tom Ford',
        amount: 130.0,
        category: ExpenseCategory.work,
        date: DateTime.now()),
    Expense(
        title: 'Earbuds ',
        amount: 125.99,
        category: ExpenseCategory.leisure,
        date: DateTime.now()),
    Expense(
        title: 'KFC Menu',
        amount: 11.99,
        category: ExpenseCategory.leisure,
        date: DateTime.now()),
    Expense(
        title: 'Mosh\'s Python Course',
        amount: 19,
        category: ExpenseCategory.other,
        date: DateTime.now()),
  ];
  //

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void addExpense(Expense expense) {
    setState(() {
      widget.expenseData.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = widget.expenseData.indexOf(expense);

    setState(() {
      widget.expenseData.remove(expense);
    });

    // inner function because we can't get the deleted expense index beforehand
    void restoreExpense() {
      setState(() {
        widget.expenseData.insert(expenseIndex, expense);
      });
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense has been removed'),
      action: SnackBarAction(label: 'Undo', onPressed: restoreExpense),
    ));
  }

  void triggerModal() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        addNewExpense: addExpense,
      ),
    );
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = ExpenseList(
      expensesList: widget.expenseData,
      deleteExpense: removeExpense,
    );

    if (widget.expenseData.isEmpty) {
      mainContent =
          const Center(child: Text('No existing expenses, try adding some !'));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('EXPENSES TRACKER'), actions: [
        IconButton(onPressed: triggerModal, icon: const Icon(Icons.add))
      ]),
      body: width < 600
          ? Column(children: [
              Chart(
                expenses: widget.expenseData,
              ),
              mainContent,
            ])
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: widget.expenseData,
                  ),
                ),
                mainContent,
              ],
            ),
    );
    //);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.expenseCategory, required this.expensesList});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.expenseCategory)
      : expensesList = allExpenses
            .where((expense) => expense.category == expenseCategory)
            .toList();

  ExpenseCategory expenseCategory;
  List<Expense> expensesList;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expensesList) {
      sum += expense.amount;
    }
    return sum;
  }
}
