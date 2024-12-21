import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_money/config/routes.dart';
import 'package:my_money/controller/expense_controller.dart';

class FloatingActionButtons extends StatelessWidget {
  final ExpenseController expenseController = Get.find<ExpenseController>();

  FloatingActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.summary);
          },
          backgroundColor: Colors.blue[700],
          child: const Icon(
            Icons.bar_chart,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 5), // Add a 5-pixel gap
        FloatingActionButton.extended(
          heroTag: 'addExpenseButton',
          onPressed: expenseController.showAddExpenseDialog,
          backgroundColor: Colors.blue[700],
          icon: const Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          ),
          label: const Text(
            'Add Expense',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
