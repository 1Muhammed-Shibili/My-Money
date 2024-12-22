import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_money/controller/notification_controller.dart';
import 'package:my_money/model/expense.dart';
import 'package:timezone/data/latest.dart' as tz;

class MainController extends GetxController {
  Future<void> initializeApp() async {
    tz.initializeTimeZones();

    Get.put(NotificationController());
    final notificationController = Get.find<NotificationController>();

    await notificationController.scheduleDailyNotification(
      hour: 20,
      minute: 00,
      title: "Daily Expense Reminder",
      body: "Don't forget to record your expenses for today!",
    );

    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseAdapter());
    await Hive.openBox<Expense>('expenses');
  }
}
