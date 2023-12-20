import 'package:evena/screens/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: fetchUserData(), // Fetch user data here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available'); // Handle case when no data is found
        } else {
          Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;

          // Extract user information from userData map
          String name = userData['name'] ?? '';
          String email = userData['email'] ?? '';
          String profileImage = 'assets/profile.jpg'; // Replace with actual image path or from userData

          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(profileImage),
                  ),
                  SizedBox(height: 20),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for editing profile or other actions
                       Navigator.push(
                       context,
                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                      );
                    },
                    child: Text('Edit Profile'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  // Function to fetch user data from Firestore (Replace this with your own logic)
  Future<DocumentSnapshot> fetchUserData() async {
    try {
      // Perform your database query here (e.g., Firestore collection().doc().get())
      // Return the DocumentSnapshot containing user data
      return await FirebaseFirestore.instance.collection('users').doc('userId123').get();
    } catch (e) {
      throw e;
    }
  }
}
