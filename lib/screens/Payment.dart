import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/screens/userHome.dart';
import 'package:evena/widgets/ticketCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

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

  @override
  Widget build(BuildContext context) {
    var creditCardForm = Form(
      key: _formKey,
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
              return null;
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
              return null;
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
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Perform payment confirmation logic here
                  showAlertDialog(context);

                  // Save card information to Firebase after confirming payment
                  saveCardInformation();
                }
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 170, 0),
              ),
              child: const Text(
                'Confirm Payment',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Page'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: creditCardForm,
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) async {
    Widget okButton = ElevatedButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (c) {
            return const UserHome();
          },
        ));
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
          .collection('/users/$user/payment')
          .doc(user.uid);

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
