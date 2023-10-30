import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewExpense});

  final void Function(Expense expense) addNewExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.other;

  void _checkFormValidation() {
    final amount = double.tryParse(amountController.text);
    final amountIsInvalid = amount == null
        ? true
        : amount <= 0
            ? true
            : false;
    if (titleController.text.trim().isEmpty || amountIsInvalid) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Wrong Input'),
                content: const Text(
                    'Please make sure you provided a correct title, amount and date'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Accept'))
                ],
              ));
      return;
    } else {
      widget.addNewExpense(Expense(
          title: titleController.text,
          amount: double.tryParse(amountController.text)!,
          category: _selectedCategory,
          date: _selectedDate!));
      Navigator.pop(context);
    }
  }

  void _triggerDatePicker() async {
    final today = DateTime.now();
    final firstDate = DateTime(today.year - 5, today.month, today.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: firstDate,
        lastDate: today);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    final formater = DateFormat.yMd();
    return formater.format(date);
  }

  Text dropDownValue = Text(ExpenseCategory.work.name);

  void onChanged(value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  @override
  Widget build(context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 48, 15, 15),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        label: Text('Amount'), prefix: Text('\$ ')),
                    controller: amountController,
                  ),
                ),
                DropdownButton(
                  value: _selectedCategory,
                  items: ExpenseCategory.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: onChanged,
                ),
                Text(_selectedDate == null
                    ? 'please pick a date'
                    : formatDate(_selectedDate!)),
                IconButton(
                    onPressed: _triggerDatePicker,
                    icon: const Icon(Icons.date_range))
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: _checkFormValidation,
                    child: const Text('Save Expense')),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
