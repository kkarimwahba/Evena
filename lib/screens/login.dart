import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/screens/adminHome.dart';
import 'package:evena/screens/reminder.dart';
import 'package:evena/screens/signup.dart';
import 'package:evena/screens/userHome.dart';
import 'package:evena/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void showReminderNotification(BuildContext context, User user) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('events')
        .where('date',
            isGreaterThanOrEqualTo: DateTime.now().toLocal().toIso8601String())
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot<Map<String, dynamic>> eventData =
          querySnapshot.docs.first;
      String eventTitle = eventData.get('title');
      DateTime eventDate = DateTime.parse(eventData.get('date'));

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'event_reminders',
        'Event Reminders',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        showWhen: false,
        sound: RawResourceAndroidNotificationSound('notification_sound'),
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      // Show the notification
      await flutterLocalNotificationsPlugin.show(
        0,
        'Event Reminder',
        'Event: $eventTitle is tomorrow!',
        platformChannelSpecifics,
        payload: 'event_id_$eventTitle',
      );

      // Dismiss the notification after 7 seconds
      Future.delayed(const Duration(seconds: 5), () async {
        await flutterLocalNotificationsPlugin.cancel(0);
      });

      // Show a SnackBar with the notification message at the top of the screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Event: $eventTitle on ${eventDate.toLocal()}'),
          duration: Duration(seconds: 7),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color.fromARGB(255, 135, 135, 135),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset('assets/images/bk.png').image,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 150.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Discover exciting events near you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 200),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 0.9 * MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.black,
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email';
                              } else if (!RegExp(r'\S+@\S+\.\S+')
                                  .hasMatch(value)) {
                                return 'Enter valid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 0.9 * MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              suffixIcon: InkWell(
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.black,
                                ),
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 0.8 * MediaQuery.of(context).size.width,
                          height: 0.13 * MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              User? user = await signinwithemailandpassword(
                                  emailController.text.trim(),
                                  passwordController.text.trim());

                              print(
                                  'Login successful, showing notification...');
                              Event event = Event(
                                  title: 'Sample Event', date: DateTime.now());
                              showReminderNotification(context, user!);

                              QuerySnapshot<Map<String, dynamic>>
                                  querySnapshot = await FirebaseFirestore
                                      .instance
                                      .collection('users')
                                      .where('uid', isEqualTo: user!.uid)
                                      .limit(1)
                                      .get();

                              if (querySnapshot.docs.isNotEmpty) {
                                String role =
                                    querySnapshot.docs.first.get('role') ?? '';

                                if (role == 'user') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserHome(),
                                  ));
                                } else if (role == 'admin') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Admin(),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Wrong email or password'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 170, 0),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 25),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 25),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) {
                                  return Signup();
                                },
                              ));
                            }),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) {
                                return Signup();
                              },
                            ));
                          },
                          child: const Text(
                            'If you dont have an account? Sign up here!',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Button color
                                onPrimary: Colors.black, // Text color
                              ),
                              child: const Row(
                                children: [
                                  ImageIcon(
                                    AssetImage('assets/images/googlelogo.png'),
                                    size: 24,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Google'),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Button color
                                onPrimary: Colors.black, // Text color
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.apple,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Text('iOS'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final DateTime date;

  Event({required this.title, required this.date});
}

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  EventDetailsScreen(this.event);

  @override
  Widget build(BuildContext context) {
    // Add your implementation for the event details screen
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Event Title: ${event.title}'),
            Text('Event Date: ${event.date}'),
          ],
        ),
      ),
    );
  }
}
