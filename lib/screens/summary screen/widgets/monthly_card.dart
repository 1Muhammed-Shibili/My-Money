import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildMonthlyCard(List<double> monthlyData) {
  final total = monthlyData.fold(0.0, (sum, amount) => sum + amount);

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green[700]!, Colors.green[900]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withOpacity(0.3),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Monthly Total',
          style: TextStyle(
            fontFamily: 'Acme',
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${NumberFormat('#,##0.00').format(total)}',
          style: const TextStyle(
            fontFamily: 'Acme',
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
