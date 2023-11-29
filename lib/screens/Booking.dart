import 'package:evena/screens/Payment.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String name = '';
  String phoneNumber = '';
  String seatPosition = '';
  int numberOfTickets = 1;

  // Validation flags
  bool isNameValid = true;
  bool isPhoneNumberValid = true;
  bool isSeatPositionValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                errorText:
                    isPhoneNumberValid ? null : 'Please enter a valid number',
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                  isPhoneNumberValid = value.isNotEmpty;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Seat Position',
                errorText: isSeatPositionValid
                    ? null
                    : 'Please enter a valid position',
              ),
              onChanged: (value) {
                setState(() {
                  seatPosition = value;
                  isSeatPositionValid = value.isNotEmpty;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Number of Tickets'),
                DropdownButton<int>(
                  value: numberOfTickets,
                  items: [1, 2, 3, 4, 5]
                      .map((int value) => DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          ))
                      .toList(),
                  onChanged: (int? value) {
                    setState(() {
                      numberOfTickets = value ?? 1;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 32.0),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Perform validation before navigating
                  if (isNameValid &&
                      isPhoneNumberValid &&
                      isSeatPositionValid) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) {
                        return Payment();
                      },
                    ));
                  }
                },
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
