import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_money/controller/expense_controller.dart';
import 'package:my_money/screens/home%20screen/widgets/expense_card.dart';
import 'package:my_money/screens/home%20screen/widgets/floating_action_buttons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ExpenseController expenseController = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        title: Text(
          'My Money',
          style: GoogleFonts.luckiestGuy(
            color: Colors.white,
            fontSize: 28,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.blue[700],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Expenses',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      expenseController.formattedTotalExpenses,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () => expenseController.pickDate(context),
                      icon:
                          const Icon(Icons.calendar_today, color: Colors.blue),
                      label: Text(
                        expenseController.selectedDate.value != null
                            ? DateFormat('MMM dd, yyyy')
                                .format(expenseController.selectedDate.value!)
                            : 'Select Date',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: () => expenseController.clearFilter(),
                      child: const Text(
                        'Clear Filter',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Obx(() {
              final groupedExpenses = expenseController.groupedExpensesByDate;

              if (groupedExpenses.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No expenses added yet.',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: groupedExpenses.entries.map((entry) {
                  final date = entry.key;
                  final expenses = entry.value;
                  final formattedDate =
                      expenseController.formatFriendlyDate(date);
                  final subtotal =
                      expenses.fold<double>(0, (sum, e) => sum + e.amount);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...expenses.map(
                        (expense) {
                          return ExpenseCard(
                            subtotal: subtotal,
                            expense: expense,
                            index: expenses.indexOf(expense),
                          );
                        },
                      )
                    ],
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtons(),
    );
  }
}
