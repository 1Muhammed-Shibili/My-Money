import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money/controller/expense_controller.dart';
import 'package:my_money/model/expense.dart';
import 'package:my_money/screens/summary%20screen/widgets/monthly_card.dart';
import 'package:my_money/screens/summary%20screen/widgets/monthly_chart.dart';
import 'package:my_money/screens/summary%20screen/widgets/weekly_card.dart';
import 'package:my_money/screens/summary%20screen/widgets/weekly_chart.dart';

class SummaryScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.find<ExpenseController>();

  SummaryScreen({Key? key}) : super(key: key);

  List<double> _getDailyTotals(List<Expense> expenses) {
    List<double> dailyTotals = List.filled(7, 0.0);

    for (var expense in expenses) {
      final weekday = expense.date.weekday - 1;
      dailyTotals[weekday] += expense.amount;
    }

    return dailyTotals;
  }

  List<double> _getWeeklyTotals(List<Expense> expenses) {
    Map<int, double> weekTotals = {};

    for (var expense in expenses) {
      final weekNumber = ((expense.date.day - 1) ~/ 7);
      weekTotals[weekNumber] = (weekTotals[weekNumber] ?? 0.0) + expense.amount;
    }

    return List.generate(5, (index) => weekTotals[index] ?? 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Expense Summary',
          style: GoogleFonts.acme(
            color: Colors.blue[700],
            fontSize: 21,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        final weeklyExpenses = expenseController.getWeeklyExpenses();
        final monthlyExpenses = expenseController.getMonthlyExpenses();

        final weeklyTotals = _getDailyTotals(weeklyExpenses);
        final monthlyTotals = _getWeeklyTotals(monthlyExpenses);

        return RefreshIndicator(
          onRefresh: () async {
            await expenseController.refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildWeeklyCard(weeklyTotals),
                  const SizedBox(height: 20),
                  buildWeeklyChart(weeklyTotals),
                  const SizedBox(height: 20),
                  buildMonthlyCard(monthlyTotals),
                  const SizedBox(height: 20),
                  buildMonthlyChart(monthlyTotals),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
