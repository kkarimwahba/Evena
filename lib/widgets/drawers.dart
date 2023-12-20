import 'package:evena/screens/login.dart';
import 'package:evena/screens/profile.dart';
import 'package:evena/screens/userHome.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  final String title;

  DrawerWidget({required this.title});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/messi.jpg'),
            )),
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
          trailing: const Icon(Icons.account_tree_rounded
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (c) {
                return ProfilePage();
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
