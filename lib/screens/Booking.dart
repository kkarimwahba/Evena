// Import necessary packages
import 'package:flutter/material.dart';
import 'Payment.dart'; // Assuming you have a Payment page

class Booking extends StatefulWidget {
  // Add a parameter to accept selected seats
  final List<int> selectedSeats;

  const Booking({Key? key, required this.selectedSeats}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String name = '';
  String phoneNumber = '';
  String email = '';
  int numberOfTickets = 1;

  // Validation flags
  bool isNameValid = true;
  bool isPhoneNumberValid = true;
  bool isEmailValid = true;
  bool isNumberOfTicketsValid = true;

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
                    isPhoneNumberValid =
                        RegExp(r'^\d{3}-\d{3}-\d{4}$').hasMatch(value);
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

              // Existing code for seat position and number of tickets

              // Display selected seats
              const SizedBox(height: 16.0),
              Text(
                "Selected Seats: ${widget.selectedSeats}",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),

              // Add other form fields or details as needed

              const SizedBox(height: 32.0),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: isFormValid()
                      ? () {
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
    return isNameValid &&
        isPhoneNumberValid &&
        isEmailValid &&
        isNumberOfTicketsValid &&
        numberOfTickets > 0;
  }
}
