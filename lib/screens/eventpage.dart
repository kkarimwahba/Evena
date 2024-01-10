import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evena/services/LocationService.dart';
import 'package:evena/screens/SeatReservation.dart';
import 'package:evena/screens/Booking.dart';

class EventDetailsPage extends StatefulWidget {
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
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      // Get a reference to the user's favorites collection
      CollectionReference favoritesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites');

      // Check if the event is already in favorites
      DocumentSnapshot eventSnapshot =
          await favoritesCollection.doc(widget.title).get();

      setState(() {
        isFavorite = eventSnapshot.exists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => toggleFavorite(),
          ),
        ],
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
                  widget.title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Image.network(widget.imagePath),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.description,
                  style: TextStyle(fontSize: 17, height: 1),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Date: ${widget.date.toLocal()}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                title: Text('Time: ${widget.time}'),
                subtitle: Text('Location: ${widget.location}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                title: Text('Category: ${widget.category}'),
                subtitle: Text('Price: ${widget.price} EGP'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                title: Text('Availability: ${widget.availability}'),
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
                        if (widget.category.toLowerCase() == 'design') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return SeatReservation(
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
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return Booking(
                                selectedSeats: [],
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
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Reservation',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        MapLoc.openMap(30.017223458801503, 31.386553285341094);
                      },
                      child: const Text('View Map'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      // Get a reference to the user's favorites collection
      CollectionReference favoritesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites');

      if (isFavorite) {
        // If the event is already favorited, remove it from favorites
        await favoritesCollection.doc(widget.title).delete();
      } else {
        // If the event is not favorited, add it to favorites
        await favoritesCollection.doc(widget.title).set({
          'title': widget.title,
          'description': widget.description,
          'date': widget.date,
          'time': widget.time,
          'location': widget.location,
          'category': widget.category,
          'price': widget.price,
          'imagePath': widget.imagePath,
          'availability': widget.availability,
        });
      }

      // Update the UI to reflect the new favorite status
      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }
}
