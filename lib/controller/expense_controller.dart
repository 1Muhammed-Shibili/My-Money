import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:my_money/model/expense.dart';
import 'package:my_money/screens/home%20screen/widgets/add_expense_dialog.dart';
import 'package:my_money/screens/home%20screen/widgets/edit_expense.dart';

class ExpenseController extends GetxController {
  var expenses = <Expense>[].obs;
  late Box<Expense> expenseBox;

  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  var filteredExpenses = <Expense>[].obs;

  Map<DateTime, List<Expense>> get groupedExpensesByDate {
    final Map<DateTime, List<Expense>> grouped = {};
    for (var expense in filteredExpenses) {
      final date =
          DateTime(expense.date.year, expense.date.month, expense.date.day);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(expense);
    }
    return grouped;
  }

  List<Expense> getWeeklyExpenses() {
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 7));

    return expenses.where((expense) {
      return expense.date.isAfter(lastWeek) && expense.date.isBefore(now);
    }).toList();
  }

  List<Expense> getMonthlyExpenses() {
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 30));

    return expenses.where((expense) {
      return expense.date.isAfter(lastWeek) && expense.date.isBefore(now);
    }).toList();
  }

  double get totalExpenses =>
      expenses.fold(0, (sum, expense) => sum + expense.amount);

  String get formattedTotalExpenses => '\$${formatAmount(totalExpenses)}';

  String formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return NumberFormat('#,##0.#############').format(amount);
    }
  }

  String formatFriendlyDate(DateTime date) {
    final today = DateTime.now();
    final difference = today.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference == 2) return 'Day Before Yesterday';

    return DateFormat('dd-MM-yyyy').format(date);
  }

  void filterByDate(DateTime date) {
    selectedDate.value = date;
    filteredExpenses.value = expenses.where((expense) {
      return DateTime(
              expense.date.year, expense.date.month, expense.date.day) ==
          DateTime(date.year, date.month, date.day);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    expenseBox = Hive.box<Expense>('expenses');
    loadExpenses();
  }

  void loadExpenses() {
    expenses.value = expenseBox.values.toList();
    filteredExpenses.value = expenses;
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    loadExpenses();
  }

  void clearFilter() {
    selectedDate.value = null;
    filteredExpenses.value = expenses;
  }

  void addExpense(Expense expense) {
    final newExpense = Expense(
      id: DateTime.now().toIso8601String(),
      description: expense.description,
      amount: expense.amount,
      date: expense.date,
    );
    expenseBox.add(newExpense);
    loadExpenses();
  }

  void editExpense(String id, Expense updatedExpense) {
    final index = expenses.indexWhere((expense) => expense.id == id);
    if (index != -1) {
      final editedExpense = Expense(
        id: id,
        description: updatedExpense.description,
        amount: updatedExpense.amount,
        date: updatedExpense.date,
      );
      expenseBox.putAt(index, editedExpense);
      loadExpenses();
    }
  }

  void deleteExpense(int index) {
    expenseBox.deleteAt(index);
    loadExpenses();
  }

  void deleteExpenseById(String id) {
    final index = expenses.indexWhere((expense) => expense.id == id);
    if (index != -1) {
      expenseBox.deleteAt(index);
      loadExpenses();
    }
  }

  void showAddExpenseDialog() {
    Get.dialog(const AddExpenseDialog());
  }

  void showEditExpenseDialog(Expense expense) {
    Get.dialog(EditExpenseDialog(expense: expense));
  }

  void pickDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blue[400]!,
              onPrimary: Colors.white,
              surface: Colors.blue[700]!,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null) {
      filterByDate(selected);
    }
  }
}
