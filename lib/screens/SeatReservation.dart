import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/screens/Booking.dart';
import 'package:flutter/material.dart';

class SeatReservation extends StatefulWidget {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final String price;
  final String imagePath;
  final String availability;

  const SeatReservation({
    Key? key,
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
  _SeatReservationState createState() => _SeatReservationState();
}

class _SeatReservationState extends State<SeatReservation> {
  final int columns = 9;
  final int rows = 11;
  late List<SeatStatus> seatStatusList;
  bool seatsReserved = false;
  List<int> selectedSeats = [];

  @override
  void initState() {
    super.initState();
    fetchReservedSeats();
  }

  Future<void> fetchReservedSeats() async {
    try {
      // Fetch reserved seats for the specific event title from Firestore
      String title = widget.title;
      DocumentSnapshot seatDocument = await FirebaseFirestore.instance
          .collection('seats')
          .doc(widget.title) // Use event title as the document ID
          .get();

      // Initialize seatStatusList based on available seats
      seatStatusList =
          List.generate(columns * rows, (index) => SeatStatus.available);

      // Update seatStatusList based on reserved seats for the current event
      if (seatDocument.exists) {
        List<int> reservedSeats = List<int>.from(seatDocument['seats']);
        reservedSeats.forEach((seatNumber) {
          setState(() {
            seatStatusList[seatNumber - 1] = SeatStatus.reserved;
          });
        });
      }

      // Update the UI to reflect the reserved seats
      setState(() {
        seatsReserved = seatStatusList.contains(SeatStatus.reserved);
      });
    } catch (e) {
      print("Error fetching reserved seats: $e");
    }
  }

  Future<void> reserveSeats(List<int> selectedSeats) async {
    try {
      // Fetch existing reserved seats
      DocumentSnapshot seatDocument = await FirebaseFirestore.instance
          .collection('seats')
          .doc(widget.title)
          .get();

      // Get the current list of reserved seats or initialize an empty list
      List<int> existingReservedSeats =
          List<int>.from(seatDocument['seats'] ?? []);

      // Add newly reserved seats to the existing list
      existingReservedSeats.addAll(selectedSeats);

      // Update reservation in Firestore
      await FirebaseFirestore.instance
          .collection('seats')
          .doc(widget.title)
          .set({'seats': existingReservedSeats}, SetOptions(merge: true));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seat Reservation for ${widget.title}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "The Stage",
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 170, 0),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) {
                    return Booking(
                      selectedSeats: selectedSeats,
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
              },
              child: Text("Go to Booking Page"),
            ),
          ],
        ),
      ),
    );
  }
}

enum SeatStatus {
  available,
  selected,
  reserved,
}
