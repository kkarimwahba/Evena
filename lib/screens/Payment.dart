import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/screens/userHome.dart';
import 'package:evena/widgets/ticketCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

User? user = FirebaseAuth.instance.currentUser;

String? userUid = user?.uid;
String? useremail = user?.email;

class Payment extends StatefulWidget {
  // Add the required event details as parameters to the constructor
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final String price;
  final String imagePath;
  final String availability;

  Payment({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.availability,
  });

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvCodeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final int maxCardNumberDigits = 16;
  final int maxccvNumber = 3;

  @override
  Widget build(BuildContext context) {
    var creditCardForm = Form(
      key: _formKey,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              width: 700,
              height: 300,
              cardNumber: cardNumberController.text,
              expiryDate: expiryDateController.text,
              cardHolderName: cardHolderNameController.text,
              cvvCode: cvvCodeController.text,
              showBackView: false,
              onCreditCardWidgetChange: (CreditCardBrand) {},
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Card Number',
              ),
              keyboardType: TextInputType.number,
              controller: cardNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid card number';
                }
                if (value.length != maxCardNumberDigits) {
                  return 'Card number must have $maxCardNumberDigits digits';
                }
                return null;
              },
              onChanged: (value) {
                value = value.replaceAll(RegExp(r'\D'), '');
                if (value.length > maxCardNumberDigits) {
                  value = value.substring(0, maxCardNumberDigits);
                }
                // if (value.length > 4) {
                //   value = value.splitMapJoin(
                //     RegExp(r".{4}"),
                //     onMatch: (match) => "${match.group(0)}",
                //     onNonMatch: (nonMatch) => nonMatch,
                //   );
                // }
                cardNumberController.value = TextEditingValue(
                  text: value,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: value.length),
                  ),
                );
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Expiry Date',
              ),
              keyboardType: TextInputType.number,
              controller: expiryDateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid expiry date';
                }
                final RegExp regExp = RegExp(r'^\d{2}/\d{2}$');
                if (!regExp.hasMatch(value)) {
                  return 'Invalid date format (MM/YY)';
                }

                return null;
              },
              onChanged: (value) {
                if (value.length == 2 && !value.contains('/')) {
                  expiryDateController.text = '$value/';
                  expiryDateController.selection = TextSelection.fromPosition(
                    TextPosition(offset: expiryDateController.text.length),
                  );
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Card Holder Name',
              ),
              controller: cardHolderNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the card holder\'s name';
                }
                return null;
              },
            ),
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'CVV Code',
                ),
                keyboardType: TextInputType.number,
                controller: cvvCodeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid CVV code';
                  }
                  if (value.length != maxccvNumber) {
                    return 'Card number must have $maxccvNumber digits';
                  }
                  return null;
                },
                onChanged: (value) {
                  value = value.replaceAll(RegExp(r'\D'), '');
                  if (value.length > maxccvNumber) {
                    value = value.substring(0, maxccvNumber);
                  }
                  cvvCodeController.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: value.length),
                    ),
                  );
                }),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    saveCardInformation();
                    showAlertDialog(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all required fields.'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 170, 0),
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: creditCardForm,
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) async {
    Widget okButton = ElevatedButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketCard(
              title: widget.title,
              description: widget.description,
              date: widget.date,
              time: widget.time,
              location: widget.location,
              category: widget.category,
              price: widget.price,
              imagePath: widget.imagePath,
              availability: widget.availability,
            ),
          ),
        );
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Payment Confirmed"),
      content: const Text("It is your ticket now"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> saveCardInformation() async {
    // Get current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Create a reference to the user's document in the 'cards' collection
      DocumentReference cardRef = FirebaseFirestore.instance
          .collection('/users/$userUid/payment')
          .doc(userUid);

      // Save card information to Firestore
      await cardRef.set({
        'cardNumber': cardNumberController.text,
        'expiryDate': expiryDateController.text,
        'cardHolderName': cardHolderNameController.text,
        'cvvCode': cvvCodeController.text,
      });
    }
  }
}