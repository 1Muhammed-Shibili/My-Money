import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:my_money/model/expense.dart';

class ExpenseController extends GetxController {
  var expenses = <Expense>[].obs;
  late Box<Expense> expenseBox;

  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  List<Expense> get filteredExpenses {
    if (selectedDate.value == null) return expenses;
    return expenses.where((expense) {
      return DateFormat('yyyy-MM-dd').format(expense.date) ==
          DateFormat('yyyy-MM-dd').format(selectedDate.value!);
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
      return amount.toStringAsFixed(2);
    }
  }

  @override
  void onInit() {
    super.onInit();
    expenseBox = Hive.box<Expense>('expenses');
    loadExpenses();
  }

  void loadExpenses() {
    expenses.value = expenseBox.values.toList();
  }

  void addExpense(Expense expense) {
    expenseBox.add(expense);
    loadExpenses();
  }

  void deleteExpense(int index) {
    expenseBox.deleteAt(index);
    loadExpenses();
  }

  void setDateFilter(DateTime? date) {
    selectedDate.value = date;
  }
}
