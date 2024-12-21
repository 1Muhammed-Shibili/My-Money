import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String description;

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime date;

  Expense({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
}
