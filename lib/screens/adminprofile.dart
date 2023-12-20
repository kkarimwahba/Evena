import 'package:evena/screens/adminEventUpdate.dart';
import 'package:evena/screens/signup.dart';
import 'package:flutter/material.dart';

class AdminProfilePage extends StatefulWidget {
  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/images/messi.jpg'), // Change with your image
            ),
            const SizedBox(height: 20),
            const Text(
              'Admin Name', // Replace with actual admin name
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'admin@example.com', // Replace with actual admin email
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement action for editing profile
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent[700],
              ),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) {
                    return const AdminEventUpdate();
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent[700],
              ),
              child: const Text('Manage Events'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) {
                    return Signup();
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent[700],
              ),
              child: const Text('Logout'),
            ),
            // Add more options or information relevant to an admin profile
          ],
        ),
      ),
    );
  }
}
