// import 'package:evena/screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class ReminderPage extends StatelessWidget {
 
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//   }

//   void showReminderNotification(BuildContext context, Event event) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'event_reminders',
//       'Event Reminders',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker', // add this line to display ticker text
//       showWhen: false,
//       sound: RawResourceAndroidNotificationSound('notification_sound'),
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     // Show the notification
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Event Reminder',
//       'Event: ${event.title} is tomorrow!',
//       platformChannelSpecifics,
//       payload: 'event_id_${event.title}', // You can customize the payload
//     );

//     // Dismiss the notification after 8 seconds
//     Future.delayed(const Duration(seconds: 8), () async {
//       await flutterLocalNotificationsPlugin.cancel(0);
//     });

//     // Handle notification tap, for example, navigate to a screen
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => EventDetailsScreen(event)),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     initializeNotifications();
//   }
//   @override
//   Widget build(BuildContext context) {
//     initializeNotifications(context); // Call the initialization method

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reminder Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('This is the Reminder Page'),
//             ElevatedButton(
//               onPressed: () {
//                 Event event =
//                     Event(title: 'Sample Event', date: DateTime.now());
//                 showReminderNotification(event);
//               },
//               child: Text('Show Reminder Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
