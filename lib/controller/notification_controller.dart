import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'scheduleNotification':
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();

        const androidDetails = AndroidNotificationDetails(
          'expense_reminder_channel',
          'Expense Reminders',
          channelDescription: 'Daily reminders to record expenses',
          importance: Importance.max,
          priority: Priority.high,
        );

        const iOSDetails = DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

        const notificationDetails = NotificationDetails(
          android: androidDetails,
          iOS: iOSDetails,
        );

        await flutterLocalNotificationsPlugin.show(
          0,
          inputData?['title'] ?? 'Reminder',
          inputData?['body'] ?? 'Time to check your expenses!',
          notificationDetails,
        );
        break;
    }
    return true;
  });
}

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    _initializeWorkManager();
  }

  Future<void> _initializeWorkManager() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }

  Future<void> _initializeNotifications() async {
    const androidInitialize = AndroidInitializationSettings('flutter_logo');
    const iOSInitialize = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        Get.toNamed('/home');
      },
    );
  }

  Future<void> scheduleDailyNotification({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final now = DateTime.now();
    final scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);
    final initialDelay = scheduledTime.isBefore(now)
        ? scheduledTime.add(const Duration(days: 1)).difference(now)
        : scheduledTime.difference(now);

    await Workmanager().registerPeriodicTask(
      'expenseReminder',
      'scheduleNotification',
      frequency: const Duration(days: 1),
      initialDelay: initialDelay,
      constraints: Constraints(
        networkType: NetworkType.not_required,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
      ),
      inputData: {
        'title': title,
        'body': body,
      },
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  Future<void> cancelAllNotifications() async {
    await Workmanager().cancelAll();
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}
