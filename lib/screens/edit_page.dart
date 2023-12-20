import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the fields with initial values if needed
    nameController.text = '';
    emailController.text = '';
    phoneController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Implement saving functionality here
                String name = nameController.text;
                String email = emailController.text;
                String phone = phoneController.text;
                // You can perform actions like updating user data here
                print('Name: $name, Email: $email, Phone: $phone');
                // After saving, you might want to navigate back or perform other actions
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
