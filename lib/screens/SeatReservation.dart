import 'package:evena/screens/Booking.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeatReservation extends StatefulWidget {
  const SeatReservation({Key? key}) : super(key: key);

  @override
  _SeatReservationState createState() => _SeatReservationState();
}

class _SeatReservationState extends State<SeatReservation> {
  final int columns = 9;
  final int rows = 11;
  late List<SeatStatus> seatStatusList;
  bool seatsReserved = false;
  List<int> selectedSeats = []; // Declare selectedSeats as a class variable

  @override
  void initState() {
    super.initState();
    seatStatusList =
        List.generate(columns * rows, (index) => SeatStatus.available);
    fetchReservedSeats();
  }

  Future<void> fetchReservedSeats() async {
    try {
      // Fetch reserved seats from Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('seats').get();

      // Update seatStatusList based on reserved seats
      querySnapshot.docs.forEach((doc) {
        List<int> reservedSeats = List<int>.from(doc['seats']);
        reservedSeats.forEach((seatNumber) {
          setState(() {
            seatStatusList[seatNumber - 1] = SeatStatus.reserved;
          });
        });
      });

      // Update the UI to reflect the reserved seats
      setState(() {
        seatsReserved = seatStatusList.contains(SeatStatus.reserved);
      });
    } catch (e) {
      print("Error fetching reserved seats: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seat Reservation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "the stage",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: columns * rows,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                int seatNumber = index + 1;
                SeatStatus seatStatus = seatStatusList[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (seatStatus == SeatStatus.available) {
                        seatStatusList[index] = SeatStatus.selected;
                        selectedSeats.add(seatNumber);
                      } else if (seatStatus == SeatStatus.selected) {
                        seatStatusList[index] = SeatStatus.available;
                        selectedSeats.remove(seatNumber);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: getSeatColor(seatStatus),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        seatNumber.toString(),
                        style: TextStyle(
                          color: getTextColor(seatStatus),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await reserveSeats(selectedSeats);
                checkReservationStatus();
              },
              child: Text("Reserve Seats"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) {
                    return Booking(
                      selectedSeats: selectedSeats,
                    );
                  },
                ));
              },
              child: Text("Go to Booking Page"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> reserveSeats(List<int> selectedSeats) async {
    try {
      // Add reservation to Firestore
      await FirebaseFirestore.instance.collection('seats').add({
        'seats': selectedSeats,
      });

      // Optionally, you can perform additional actions after reservation
    } catch (e) {
      print("Error reserving seats: $e");
    }
  }

  void checkReservationStatus() {
    // You can customize this logic based on your requirements
    setState(() {
      seatsReserved = seatStatusList.contains(SeatStatus.reserved);
    });
  }

  Color getSeatColor(SeatStatus status) {
    switch (status) {
      case SeatStatus.available:
        return Colors.green;
      case SeatStatus.selected:
        return Colors.orange;
      case SeatStatus.reserved:
        return Colors.red;
    }
  }

  Color getTextColor(SeatStatus status) {
    return status == SeatStatus.available ? Colors.white : Colors.black;
  }
}

enum SeatStatus {
  available,
  selected,
  reserved,
}
