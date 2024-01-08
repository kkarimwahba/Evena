import 'package:evena/Theme/theme_provider.dart';
import 'package:evena/firebase_options.dart';
import 'package:evena/screens/adminHome.dart';
import 'package:evena/screens/admin_add.dart';
import 'package:evena/screens/adminprofile.dart';
import 'package:evena/screens/reminder.dart';
import 'package:evena/screens/splashScreen.dart';
import 'package:evena/Theme/themedata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
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
