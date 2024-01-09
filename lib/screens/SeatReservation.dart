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

  Stream<DocumentSnapshot> getSeatDocumentStream() {
    return FirebaseFirestore.instance
        .collection('seats')
        .doc(widget.title)
        .snapshots();
  }

  Future<void> fetchReservedSeats() async {
    try {
      String title = widget.title;
      DocumentSnapshot seatDocument = await FirebaseFirestore.instance
          .collection('seats')
          .doc(widget.title)
          .get();

      seatStatusList =
          List.generate(columns * rows, (index) => SeatStatus.available);

      if (seatDocument.exists) {
        List<int> reservedSeats = List<int>.from(seatDocument['seats']);
        reservedSeats.forEach((seatNumber) {
          setState(() {
            seatStatusList[seatNumber - 1] = SeatStatus.reserved;
          });
        });
      }

      setState(() {
        seatsReserved = seatStatusList.contains(SeatStatus.reserved);
      });
    } catch (e) {
      print("Error fetching reserved seats: $e");
    }
  }

  Future<void> reserveSeats(List<int> selectedSeats) async {
    try {
      DocumentSnapshot seatDocument = await FirebaseFirestore.instance
          .collection('seats')
          .doc(widget.title)
          .get();

      List<int> existingReservedSeats =
          List<int>.from(seatDocument['seats'] ?? []);

      existingReservedSeats.addAll(selectedSeats);

      await FirebaseFirestore.instance
          .collection('seats')
          .doc(widget.title)
          .set({'seats': existingReservedSeats}, SetOptions(merge: true));
    } catch (e) {
      print("Error reserving seats: $e");
    }
  }

  void checkReservationStatus() {
    setState(() {
      seatsReserved = seatStatusList.contains(SeatStatus.reserved);
    });
  }

  Color getSeatColor(int seatNumber, List<int> reservedSeats) {
    if (selectedSeats.contains(seatNumber)) {
      return Colors.orange;
    } else if (reservedSeats.contains(seatNumber)) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  Color getTextColor(int seatNumber, List<int> reservedSeats) {
    return selectedSeats.contains(seatNumber) ? Colors.black : Colors.white;
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
            StreamBuilder<DocumentSnapshot>(
              stream: getSeatDocumentStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                List<int> reservedSeats =
                    List<int>.from(snapshot.data!['seats']);

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: columns * rows,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    int seatNumber = index + 1;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (seatStatusList[index] == SeatStatus.available) {
                            seatStatusList[index] = SeatStatus.selected;
                            selectedSeats.add(seatNumber);
                          } else if (seatStatusList[index] ==
                              SeatStatus.selected) {
                            seatStatusList[index] = SeatStatus.available;
                            selectedSeats.remove(seatNumber);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: getSeatColor(seatNumber, reservedSeats),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            seatNumber.toString(),
                            style: TextStyle(
                              color: getTextColor(seatNumber, reservedSeats),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
