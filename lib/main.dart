import 'package:evena/firebase_options.dart';
import 'package:evena/screens/adminHome.dart';
import 'package:evena/screens/admin_add.dart';
import 'package:evena/screens/adminprofile.dart';
import 'package:evena/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
