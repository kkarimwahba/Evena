import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/screens/adminEventUpdate.dart';
import 'package:evena/screens/login.dart';
import 'package:evena/screens/userProfile.dart';
import 'package:evena/services/userServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminProfilePage extends StatefulWidget {
  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  late User adminUser; // Assuming the admin user is already logged in
  late String adminName = '';
  late String adminEmail = '';

  @override
  void initState() {
    super.initState();
    fetchAdminData();
  }

  Future<void> fetchAdminData() async {
    try {
      adminUser = FirebaseAuth.instance.currentUser!;
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch admin data based on UID
      DocumentSnapshot<Map<String, dynamic>> adminDoc =
          await firestore.collection('admins').doc(adminUser.uid).get();

      // Check if the document exists before accessing fields
      if (adminDoc.exists) {
        // Set initial values for the variables
        setState(() {
          adminName = adminDoc.get('name') ?? '';
          adminEmail = adminDoc.get('email') ?? '';
        });
        print('Fetching admin data for UID: ${adminUser.email}');
      } else {
        print('Admin document does not exist for UID: ${adminUser.uid}');
      }
    } catch (error) {
      // Handle error, if any
      print('Error fetching admin data: $error');
    }
  }

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
            Text(
              adminName, // Use the fetched admin name
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              adminEmail, // Use the fetched admin email
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) {
                    return UserProfile(
                      user: adminUser,
                    );
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent[700],
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.black),
              ),
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
              child: const Text(
                'Manage Events',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                signOut();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) {
                    return Login();
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent[700],
              ),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
            ),
            // Add more options or information relevant to an admin profile
          ],
        ),
      ),
    );
  }
}
