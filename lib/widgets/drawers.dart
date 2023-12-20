import 'package:evena/screens/login.dart';
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
              backgroundColor: Colors.white,
              radius: 50,
              backgroundImage: AssetImage('assets/images/user.png'),
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
