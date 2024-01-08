import 'package:evena/screens/SeatReservation.dart';
import 'package:evena/screens/Booking.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final String price;
  final String imagePath;
  final String availability;

  EventDetailsPage({
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Image.network(imagePath),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 17,
                      height: 1),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Date: ${date.toLocal()}'),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(description),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('Date: ${date.toLocal()}'),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                title: Text('Time: $time'),
                subtitle: Text('Location: $location'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                title: Text('Category: $category'),
                subtitle: Text('Price: $price EGP'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                title: Text('Availability: $availability'),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 170, 0),
                      ),
                      onPressed: () {
                        if (category.toLowerCase() == 'design') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return SeatReservation(
                                title: title,
                                description: description,
                                date: date,
                                time: time,
                                location: location,
                                category: category,
                                price: price,
                                imagePath: imagePath,
                                availability: availability,
                              );
                            },
                          ));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return Booking(
                                selectedSeats: [],
                                title: this.title,
                                description: this.description,
                                date: this.date,
                                time: this.time,
                                location: this.location,
                                category: this.category,
                                price: this.price,
                                imagePath: this.imagePath,
                                availability: this.availability,
                              );
                            },
                          ));
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Reservation',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) {
                    //         return Mappage();
                    //       },
                    //     ));
                    //   },
                    //   child: const Text('View Map'),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
