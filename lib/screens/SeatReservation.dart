import 'package:evena/screens/Booking.dart';
import 'package:flutter/material.dart';

class SeatReservation extends StatefulWidget {
  const SeatReservation({Key? key}) : super(key: key);

  @override
  _SeatReservationState createState() => _SeatReservationState();
}

class _SeatReservationState extends State<SeatReservation> {
  final int columns = 9;
  final int rows = 11;
  late List<bool> isSeatSelected; // Use late initialization

  List<int> reservedSeats = [
    2,
    3,
    4,
    5,
    8,
    10,
    11,
    14,
    16,
    17,
    18,
    19,
    20,
    21,
    27,
    28,
    32,
    33,
    34,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    61,
    62,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    85,
    86,
    92,
    93,
    94,
    95,
    100,
    101,
    102,
    103,
    106,
    107,
    108
  ]; // Example: Seats already reserved

  @override
  void initState() {
    super.initState();
    // Initialize isSeatSelected list with false values
    isSeatSelected = List.generate(columns * rows, (index) => false);
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
            // Seat Map
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
                bool isReserved = reservedSeats.contains(seatNumber);
                bool isSelected = isSeatSelected[index];

                return GestureDetector(
                  onTap: () {
                    if (!isReserved) {
                      setState(() {
                        isSeatSelected[index] = !isSelected;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isReserved
                          ? Colors.grey // Reserved seat color
                          : isSelected
                              ? Colors.red // Selected seat color
                              : Colors.green, // Available seat color
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        seatNumber.toString(),
                        style: TextStyle(
                          color: isReserved
                              ? Colors.black // Reserved seat text color
                              : Colors
                                  .white, // Available or Selected seat text color
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
              onPressed: () {
                List<int> selectedSeats = [];
                for (int i = 0; i < isSeatSelected.length; i++) {
                  if (isSeatSelected[i]) {
                    selectedSeats.add(i + 1);
                  }
                }
                // Navigate to Booking page with selected seats
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Booking(selectedSeats: selectedSeats),
                  ),
                );
              },
              child: Text("Reserve Seats"),
            ),
          ],
        ),
      ),
    );
  }
}
