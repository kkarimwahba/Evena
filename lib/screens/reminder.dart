// import 'dart:async';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class ReminderHelper {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static const int eventReminderNotificationId = 0;

//   ReminderHelper() {
//     initializeNotifications();
//   }

//   Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//   }

//   void scheduleReminder(Event event) {
//     final int reminderDelaySeconds =
//         0; // Delay in seconds before showing the reminder

//     Timer(Duration(seconds: reminderDelaySeconds), () {
//       // This code will run after the specified delay
//       showReminderNotification(event);
//     });
//   }

//   void showReminderNotification(Event event) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'event_reminders',
//       'Event Reminders',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//       sound: RawResourceAndroidNotificationSound('notification_sound'),
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Event Reminder',
//       'Event: ${event.title} is tomorrow!',
//       platformChannelSpecifics,
//       payload: 'event_id_${event.title}', // You can customize the payload
//     );
//   }
// }

// class Event {
//   final String title;
//   final DateTime date;

//   Event({required this.title, required this.date});
// }
