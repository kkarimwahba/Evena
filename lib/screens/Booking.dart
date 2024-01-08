import 'package:evena/screens/Payment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Booking extends StatefulWidget {
  final List<int> selectedSeats;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final String price;
  final String imagePath;
  final String availability;

  const Booking({
    Key? key,
    required this.selectedSeats,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.availability,
  }) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String name = '';
  String phoneNumber = '';
  String email = '';
  bool isNameValid = true;
  bool isPhoneNumberValid = true;
  bool isEmailValid = true;

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: isNameValid ? null : 'Please enter a valid name',
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                    isNameValid = value.isNotEmpty;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  errorText: isPhoneNumberValid
                      ? null
                      : 'Please enter a valid phone number (e.g., 123-456-7890)',
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                    isPhoneNumberValid = value.isNotEmpty;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: isEmailValid
                      ? null
                      : 'Please enter a valid email address',
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    email = value;
                    isEmailValid =
                        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value);
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              Text(
                "Selected Seats: ${widget.selectedSeats.join(', ')}",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: isFormValid()
                      ? () async {
                          // await storeUserData();
                          await reserveSeats(widget.selectedSeats);
                          // await saveCardInformation();
                          if (name.isEmpty ||
                              phoneNumber.isEmpty ||
                              email.isEmpty) {
                            showErrorSnackBar(
                                context, 'Invalid Form or Card Details');
                          } else {
                            // Your existing code for button press
                            // e.g., await storeUserData();
                            // await reserveSeats(widget.selectedSeats);
                            // await saveCardInformation();
                            showSuccessSnackBar(context, 'Booking Successful');
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) {
                                return Payment(
                                  title: widget.title,
                                  description: widget.description,
                                  date: widget.date,
                                  time: widget.time,
                                  location: widget.location,
                                  category: widget.category,
                                  price: widget.price,
                                  imagePath: widget.imagePath,
                                  availability: widget.availability,
                                );
                              },
                            ));
                          }
                        }
                      : () {
                          showErrorSnackBar(
                              context, 'Invalid Form or Card Details');
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 170, 0),
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isFormValid() {
    return isNameValid && isPhoneNumberValid && isEmailValid;
  }

  Future<void> reserveSeats(List<int> selectedSeats) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        QuerySnapshot<Map<String, dynamic>> userRef = await FirebaseFirestore
            .instance
            .collection('users')
            .where('uid', isEqualTo: userUid)
            .limit(1)
            .get();
        if (userRef.docs.isNotEmpty) {
          var firstDocument = userRef.docs.first;
          var documentRefrence = firstDocument.reference;
          await documentRefrence
              .collection('tickets')
              .doc()
              .set({'seats': selectedSeats});
        } else {
          print('error');
        }
      }
    } catch (e) {
      print("Error reserving seats: $e");
    }
  }
}
