import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;
  @override
  Widget build(context) {
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    expense.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(categoryList[expense.category]),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('\$ ${expense.amount.toString()}'),
                  const Spacer(),
                  Text(expense.formatedDate)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
