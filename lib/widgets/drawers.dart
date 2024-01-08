import 'package:evena/screens/login.dart';
import 'package:evena/screens/userHome.dart';
import 'package:evena/screens/userProfile.dart';
import 'package:evena/services/userServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  final String title;

  DrawerWidget({required this.title});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User? user;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Fetch user data (you may need to adjust this based on your user authentication)
      User? currentUser = FirebaseAuth.instance.currentUser;
      setState(() {
        user = currentUser;
      });
      print('User ID after login: ${user?.uid}');
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xffE6E6E6),
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    color: Color(0xffCCCCCC),
                    size: 40,
                  ),
                ),
                SizedBox(height: 8),
                // Text(
                //   user!.uid,
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text('Home'),
          trailing: const Icon(Icons.home),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (c) {
                return const UserHome();
              },
            ));
          },
        ),
        ListTile(
          title: const Text('Profile'),
          trailing: const Icon(Icons.person),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (c) {
                return UserProfile(user: user); // Pass user data to UserProfile
              },
            ));
          },
        ),
        ListTile(
          trailing: const Icon(Icons.event_busy),
          title: const Text('Reservations'),
          onTap: () {},
        ),
        ListTile(
          trailing: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            signOut();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (c) {
                return Login();
              },
            ));
          },
        ),
      ]),
    );
  }
}
