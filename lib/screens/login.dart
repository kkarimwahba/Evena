import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/Theme/theme_provider.dart';
import 'package:evena/Theme/themedata.dart';
import 'package:evena/screens/adminHome.dart';
import 'package:evena/screens/signup.dart';
import 'package:evena/screens/userHome.dart';
import 'package:evena/services/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Text editing controllers for email and password
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Placeholder function for toggleFilter
  void toggleFilter() {}
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
// Define text and button color based on the theme
    Color textColor =
        themeProvider.themeData == lightMode ? Colors.black : Colors.white;
    Color buttonColor = themeProvider.themeData == lightMode
        ? const Color.fromARGB(255, 255, 170, 0)
        : Colors.black;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event List'),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: toggleFilter, // Call the toggleFilter function
            ),
            IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                // Toggle dark mode
                themeProvider.toggleTheme();
              },
            ),
          ],
        ),

        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset('assets/images/bk.png').image,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 150.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Discover exciting events near you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 200),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 0.9 * MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.black,
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email';
                              } else if (!RegExp(r'\S+@\S+\.\S+')
                                  .hasMatch(value)) {
                                return 'Enter valid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 0.9 * MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              suffixIcon: InkWell(
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.black,
                                ),
                              ),
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: 0.8 * MediaQuery.of(context).size.width,
                        height: 0.13 * MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            User? user = await signinwithemailandpassword(
                                emailController.text.trim(),
                                passwordController.text.trim());

                            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .where('uid', isEqualTo: user!.uid)
                                    .limit(1)
                                    .get();

                            if (querySnapshot.docs.isNotEmpty) {
                              String role =
                                  querySnapshot.docs.first.get('role') ??
                                      ''; // Get user role

                              if (role == 'user') {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserHome(),
                                ));
                              } else if (role == 'admin') {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Admin(),
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Wrong email or password'),
                                    duration: Duration(
                                        seconds:
                                            3), // Adjust the duration as needed
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 170, 0),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 25),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) {
                              return Signup();
                            },
                          ));
                        },
                        child: const Text(
                          'If you dont have an account? Sign up here!',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '-----------------------------',
                            style: TextStyle(color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'OR',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Text(
                            '-----------------------------',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(),
                            child: const Row(
                              children: [
                                ImageIcon(
                                  AssetImage('assets/images/googlelogo.png'),
                                  size: 24,
                                ),
                                SizedBox(width: 10),
                                Text('Google'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(// Text color
                                ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.apple,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text('iOS'),
                              ],
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 0.8 * MediaQuery.of(context).size.width,
                          height: 0.13 * MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              User? user = await signinwithemailandpassword(
                                  emailController.text.trim(),
                                  passwordController.text.trim());

                              QuerySnapshot<Map<String, dynamic>>
                                  querySnapshot = await FirebaseFirestore
                                      .instance
                                      .collection('users')
                                      .where('uid', isEqualTo: user!.uid)
                                      .limit(1)
                                      .get();

                              if (querySnapshot.docs.isNotEmpty) {
                                String role =
                                    querySnapshot.docs.first.get('role') ??
                                        ''; // Get user role

                                if (role == 'user') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserHome(),
                                  ));
                                } else if (role == 'admin') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Admin(),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Wrong email or password'),
                                      duration: Duration(
                                          seconds:
                                              3), // Adjust the duration as needed
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 170, 0),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 25),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                            //  style: ElevatedButton.styleFrom(
                            //     backgroundColor:
                            //         const Color.fromARGB(255, 255, 170, 0),
                            //   ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 25),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) {
                                  return Signup();
                                },
                              ));
                            }),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) {
                                return Signup();
                              },
                            ));
                          },
                          child: Text(
                            'If you dont have an account? Sign up here!',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Button color
                                onPrimary: Colors.black, // Text color
                              ),
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage('assets/images/googlelogo.png'),
                                    size: 24,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Google'),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Button color
                                onPrimary: Colors.black, // Text color
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.apple,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Text('iOS'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
