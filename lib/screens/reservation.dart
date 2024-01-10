import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationPage extends StatefulWidget {
  final User? user;

  ReservationPage({required this.user});

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _reservedSeats = [];

  @override
  void initState() {
    super.initState();
    _loadReservedSeats();
  }

  Future<void> _loadReservedSeats() async {
    try {
      QuerySnapshot reservationSnapshot = await _firestore
          .collection('users')
          .doc(widget.user?.uid)
          .collection('tickets')
          .get();

      List<String> reservedSeats = [];
      for (QueryDocumentSnapshot reservation in reservationSnapshot.docs) {
        reservedSeats.add(reservation.get('tickets'));
      }

      setState(() {
        _reservedSeats = reservedSeats;
      });
    } catch (e) {
      print('Error loading reserved seats: $e');
    }
  }

  Future<void> _removeSeat(String seatId) async {
    try {
      await _firestore
          .collection('users')
          .doc(widget.user?.uid)
          .collection('tickets')
          .where('tickets', isEqualTo: seatId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      _loadReservedSeats();
    } catch (e) {
      print('Error removing seat: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Reservations'),
      ),
      body: ListView.builder(
        itemCount: _reservedSeats.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Reserved Seat: ${_reservedSeats[index]}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeSeat(_reservedSeats[index]),
            ),
          );
        },
      ),
    );
  }
}
