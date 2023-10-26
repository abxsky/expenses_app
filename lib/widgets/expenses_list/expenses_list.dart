import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expensesList, required this.deleteExpense});
  final void Function(Expense expense) deleteExpense;
  final List<Expense> expensesList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expensesList.length,
        itemBuilder: (ctx, index) => Dismissible(
            onDismissed: (direction) => deleteExpense(expensesList[index]),
            key: ValueKey(ExpenseItem(expense: expensesList[index])),
            child: ExpenseItem(expense: expensesList[index])));
  }
}
