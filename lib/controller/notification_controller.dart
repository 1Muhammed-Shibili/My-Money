// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;

// class NotificationController {
//   static Future<void> initializeNotifications(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitializationSettings);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     tz.initializeTimeZones();
//   }

//   static Future<void> scheduleDailyNotification(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Daily Expense Reminder',
//       'Don\'t forget to record your expenses!',
//       _nextInstanceOf8PM(),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'daily_reminder_channel',
//           'Daily Reminders',
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }

//   static tz.TZDateTime _nextInstanceOf8PM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 20);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
// }
