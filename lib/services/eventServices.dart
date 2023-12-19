// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:evena/models/events.dart';

// class EventService {
//   final CollectionReference eventsCollection =
//       FirebaseFirestore.instance.collection('events');

//   Future<void> addEvent(Event event) async {
//     try {
//       await eventsCollection.add({
//         'title': event.title,
//         'description': event.description,
//         'date': event.date,
//         'time': event.time,
//         'location': event.location,
//         'category': event.category,
//         'price': event.price,
//         'image': event.image,
//         'availability': event.availability,
//       });
//       print('Event added successfully!');
//     } catch (e) {
//       print('Error adding event: $e');
//     }
//   }
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class EventService {
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  Future<void> addEvent(Map<String, dynamic> eventData) async {
    try {
      await eventsCollection.add(eventData);
      print('Event added successfully to Firestore!');
    } catch (e) {
      print('Error adding event to Firestore: $e');
    }
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:evena/models/events.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class EventService {
//   final CollectionReference eventsCollection =
//       FirebaseFirestore.instance.collection('events');
//   final FirebaseStorage storage = FirebaseStorage.instance;

//   Future<void> addEvent(Event event) async {
//     try {
//       Map<String, dynamic> eventData = event.toJson();
//       String imagePath = eventData['imagePath'] ?? '';

//       if (event.imageFile != null) {
//         // Upload the image to Firebase Storage
//         UploadTask uploadTask =
//             storage.ref().child(imagePath).putFile(event.imageFile!);
//         TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
//         String imageUrl = await taskSnapshot.ref.getDownloadURL();

//         // Store event details in Firestore, including the image URL
//         eventData['imageUrl'] = imageUrl;
//         await eventsCollection.add(eventData);
//       } else {
//         // If no image is selected, store event details in Firestore without image URL
//         await eventsCollection.add(eventData);
//       }

//       print('Event added successfully to Firestore!');
//     } catch (e) {
//       print('Error adding event to Firestore: $e');
//     }
//   }
// }
