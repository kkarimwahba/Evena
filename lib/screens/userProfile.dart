import 'package:evena/models/users.dart';
import 'package:evena/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  final User? user;

  const UserProfile({
    required this.user,
  });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      User? currentUser = widget.user;

      // Fetch user data based on UID
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(currentUser?.uid).get();

      // Check if the document exists before accessing fields
      // Inside the fetchUserData method, after fetching the document
      if (userDoc.exists) {
        // Set initial values for the controllers with default values if fields are null
        _nameController.text = userDoc.get('name') ?? '';
        _emailController.text = userDoc.get('email') ?? '';
        _phoneController.text = userDoc.get('phone') ?? '';
        _passwordController.text = userDoc.get('password') ?? '';
      } else {
        print('Fetched user data: ${userDoc.data()}');

        print('User document does not exist for UID: ${currentUser?.uid}');
      }
    } catch (error) {
      // Handle error, if any
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder(
              future: fetchUserData(), // Use the future to fetch user data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                      'Loading...'); // Show loading indicator while fetching data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    'Welcome, ${_nameController.text}.',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '${user?.email}'),
              enabled: false, // Disable email editing
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle the update logic here
                updateUserData();
              },
              child: const Text('Update'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle the delete logic here
                deleteAccount();
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to update user data
  Future<void> updateUserData() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Update the user document in the 'users' collection
      await firestore.collection('users').doc(user?.uid).update({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User data updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      // Handle error, if any
      print('Error updating user data: $error');
    }
  }

  // Function to delete the user account
  Future<void> deleteAccount() async {
    try {
      // Delete the user account
      await user?.delete();

      // Navigate to the login or signup page after account deletion
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
        (route) => false,
      );
    } catch (error) {
      // Handle error, if any
      print('Error deleting account: $error');
    }
  }
}
