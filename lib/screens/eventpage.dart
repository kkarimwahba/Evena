import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final String price;
  // Add image field if stored in Firestore
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
    // Add image field if stored in Firestore
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
            // Add Image widget here if imagePath is used
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
            // Add any other details you want to display
          ],
        ),
      ),
    );
  }
}
