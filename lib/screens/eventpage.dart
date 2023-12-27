import 'package:evena/screens/Mappage.dart';
import 'package:evena/screens/SeatReservation.dart';
import 'package:evena/screens/Booking.dart';
import 'package:evena/widgets/eventmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
            Image.network(imagePath),
            ListTile(
              title: Text(title),
              subtitle: Text('Date: ${date.toLocal()}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description),
            ),
            ListTile(
              title: Text('Time: $time'),
              subtitle: Text('Location: $location'),
            ),
            ListTile(
              title: Text('Category: $category'),
              subtitle: Text('Price: $price \$'),
            ),
            ListTile(
              title: Text('Availability: $availability'),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: ElevatedButton(
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
                          ); // Example, replace with actual data
                        },
                      ));
                    }
                  },
                  child: const Text(
                    'Reservation',
                  ),
// =======
//                 child: Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         if (category.toLowerCase() == 'design') {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) {
//                               return SeatReservation(
//                                 title: title,
//                                 description: description,
//                                 date: date,
//                                 time: time,
//                                 location: location,
//                                 category: category,
//                                 price: price,
//                                 imagePath: imagePath,
//                                 availability: availability,
//                               );
//                             },
//                           ));
//                         } else {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) {
//                               return Booking(
//                                 selectedSeats: [],
//                                 title: this.title,
//                                 description: this.description,
//                                 date: this.date,
//                                 time: this.time,
//                                 location: this.location,
//                                 category: this.category,
//                                 price: this.price,
//                                 imagePath: this.imagePath,
//                                 availability: this.availability,
//                               );
//                             },
//                           ));
//                         }
//                       },
//                       child: const Text('Reservation'),
//                     ),
//                   ],
// >>>>>>> d0ea4b7a8231499b2b12f9cb0851c7e004814473
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) {
            //       return const Mappage();
            //     }));
            //   },
            //   child: const Text(
            //     'map',
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
