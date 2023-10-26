import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});
  final List<Expense>? expenseData = [];
  //

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void addExpense(Expense expense) {
    setState(() {
      widget.expenseData!.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = widget.expenseData!.indexOf(expense);

    setState(() {
      widget.expenseData!.remove(expense);
    });

    // inner function because we can't get the deleted expense index beforehand
    void restoreExpense() {
      setState(() {
        widget.expenseData!.insert(expenseIndex, expense);
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
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              addNewExpense: addExpense,
            ));
  }

  @override
  Widget build(context) {
    Widget mainContent = ExpenseList(
      expensesList: widget.expenseData!,
      deleteExpense: removeExpense,
    );

    if (widget.expenseData!.isEmpty) {
      mainContent = const Center(
          child: Text(
        'No existing expenses, try adding some !',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ));
    }
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: triggerModal, icon: const Icon(Icons.add))
      ]),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 143, 0, 0),
            Color.fromARGB(255, 98, 1, 116)
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: Center(
          child: mainContent,
        ),
      ),
    );
  }
}
