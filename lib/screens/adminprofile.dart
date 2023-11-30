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
        title: Text('Admin Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/admin_profile.png'), // Change with your image
            ),
            SizedBox(height: 20),
            Text(
              'Admin Name', // Replace with actual admin name
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'admin@example.com', // Replace with actual admin email
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement action for editing profile
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement action for managing events or any other admin-specific action
              },
              child: Text('Manage Events'),
            ),
            // Add more options or information relevant to an admin profile
          ],
        ),
      ),
    );
  }
}

