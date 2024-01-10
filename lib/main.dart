import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:evena/Theme/theme_provider.dart';
import 'package:evena/firebase_options.dart';
import 'package:evena/screens/adminHome.dart';
import 'package:evena/screens/admin_add.dart';
import 'package:evena/screens/adminprofile.dart';
import 'package:evena/screens/reminder.dart';
import 'package:evena/screens/splashScreen.dart';
import 'package:evena/Theme/themedata.dart';
import 'package:evena/screens/userHome.dart';
import 'package:evena/services/localdata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize the database and fetch data based on connectivity
  await initializeDatabaseAndFetchData();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

Future<void> initializeDatabaseAndFetchData() async {
  LocalDatabase localDatabase = LocalDatabase();

  try {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool isConnected = (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);

    await localDatabase.initializeDatabase();

    // Check connectivity and navigate to the appropriate page
    if (isConnected) {
      // Redirect to AdminHome for online mode (replace with your logic)
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: UserHome(), // Replace with your online home page
          theme: ThemeData(), // Replace with your theme
          routes: {},
        ),
      );

      // Fetch data from Firebase
      await fetchEventsFromFirebase();
    } else {
      // Redirect to UserHome for offline mode
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: UserHome(), // Replace with your offline home page
          theme: ThemeData(), // Replace with your theme
          routes: {},
        ),
      );

      // Fetch data from SQLite
      await fetchEventsFromSQLite(localDatabase);
    }
  } catch (error) {
    print('Error initializing database: $error');
  }
}

Future<void> fetchEventsFromFirebase() async {
  // Implement fetching data from Firebase
  // ...

  // Example: Fetch events from Firestore
  try {
    var snapshot = await FirebaseFirestore.instance.collection('events').get();
    var events = snapshot.docs.map((doc) => Event.fromMap(doc.data())).toList();
    print('Fetched events from Firebase: $events');
  } catch (error) {
    print('Error fetching events from Firebase: $error');
  }
}

Future<void> fetchEventsFromSQLite(LocalDatabase localDatabase) async {
  // Implement fetching data from SQLite
  // ...

  // Example: Fetch events from SQLite database
  try {
    var events = await localDatabase.getEvents();
    print('Fetched events from SQLite: $events');
  } catch (error) {
    print('Error fetching events from SQLite: $error');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {},
    );
  }
}
