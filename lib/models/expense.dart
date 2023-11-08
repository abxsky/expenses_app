import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

var generatedId = const Uuid().v4();

enum ExpenseCategory { food, fuel, work, clothes, leisure, other }

Map<ExpenseCategory, IconData> categoryList = {
  ExpenseCategory.clothes: Icons.man_2,
  ExpenseCategory.food: Icons.fastfood,
  ExpenseCategory.leisure: Icons.park,
  ExpenseCategory.fuel: Icons.local_gas_station,
  ExpenseCategory.other: Icons.donut_large,
  ExpenseCategory.work: Icons.plumbing
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  }) : id = generatedId;

  String title;
  double amount;
  ExpenseCategory category;
  DateTime date;
  String id;

  String get formatedDate {
    var formater = DateFormat.yMd();
    return formater.format(date);
  }
}
