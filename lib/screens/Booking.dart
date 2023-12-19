import 'package:evena/screens/Payment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Booking extends StatefulWidget {
  final List<int> selectedSeats;

  const Booking({Key? key, required this.selectedSeats}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String name = '';
  String phoneNumber = '';
  String email = '';

  // Validation flags
  bool isNameValid = true;
  bool isPhoneNumberValid = true;
  bool isEmailValid = true;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Booking'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name Text Field
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

              // Phone Number Text Field
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

              // Email Text Field
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

              // Display selected seats dynamically
              const SizedBox(height: 16.0),
              Text(
                "Selected Seats: ${widget.selectedSeats.join(', ')}",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              // ... (similar fields for expiry date, card holder name, and CVV)

              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: isFormValid()
                      ? () async {
                          await storeUserData();
                          await reserveSeats(widget.selectedSeats);
                          await saveCardInformation();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) {
                              return Payment();
                            },
                          ));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 170, 0),
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 25,
                    ),
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

  Future<void> storeUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').add({
          'name': name,
          'phone': phoneNumber,
          'email': email,
          'seatsnum': widget.selectedSeats,
        });
      }
    } catch (e) {
      print("Error storing user data: $e");
    }
  }

  Future<void> reserveSeats(List<int> selectedSeats) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;
        await FirebaseFirestore.instance
            .collection('/users/$user/Booking')
            .doc(userUid)
            .set({'seats': selectedSeats});
      }
    } catch (e) {
      print("Error reserving seats: $e");
    }
  }

  Future<void> saveCardInformation() async {
    // Get current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Create a reference to the user's document in the 'cards' collection
        DocumentReference cardRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cards')
            .doc();

        // Save card information to Firestore
        await cardRef.set({
          'cardNumber': cardNumberController.text,
          'expiryDate': expiryDateController.text,
          'cardHolderName': cardHolderNameController.text,
          'cvvCode': cvvCodeController.text,
        });
      } catch (e) {
        print("Error saving card information: $e");
      }
    }
  }
}
