import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/screens/adminEventUpdate.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditEventPage extends StatefulWidget {
  // Define parameters to receive event details
  final String imagePath;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final String price;
  final String availability;

  const EditEventPage({
    // Receive event details as parameters
    required this.imagePath,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.price,
    required this.availability,
  });

  @override
  _EditEventPageState createState() => _EditEventPageState();
}



class _EditEventPageState extends State<EditEventPage> {
  // Define controllers for editing event details
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _locationController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;
  late TextEditingController _availabilityController;
  File? _pickedImage;
  String _imageUrl = '';

  Future<void> deleteEvent() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Delete the event document from the 'events' collection based on the provided document ID
     QuerySnapshot querySnapshot = await firestore.collection('events')
        .where('title', isEqualTo: widget.title) // Change this to the field you want to use for finding the document
        .limit(1)
        .get();

        if (querySnapshot.docs.isNotEmpty) {
           DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

          await documentSnapshot.reference.delete();

        }


      // Show a success message
      Navigator.pop(context);
    } catch (error) {
      // Handle error, if any
      print('Error deleting event: $error');
    }
  }
  

  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

// Function to upload the image to Firebase Storage
  Future<String?> uploadImageToStorage() async {
    try {
      if (_pickedImage != null) {
        // Create a reference to the Firebase Storage bucket
        var storageReference = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('event_images/${DateTime.now().millisecondsSinceEpoch}');

        // Upload the file to Firebase Storage
        await storageReference.putFile(_pickedImage!);

        // Get the download URL of the uploaded file
        return await storageReference.getDownloadURL();
      }
      return null;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }


   @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    _dateController = TextEditingController(text: widget.date.toIso8601String());
    _timeController = TextEditingController(text: widget.time);
    _locationController = TextEditingController(text: widget.location);
    _categoryController = TextEditingController(text: widget.category);
    _priceController = TextEditingController(text: widget.price);
    _availabilityController = TextEditingController(text: widget.availability);
  }

 Future<void> updateEvent(Event event) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Query for the document based on the 'title' field
    QuerySnapshot querySnapshot = await firestore.collection('events')
        .where('title', isEqualTo: widget.title) // Change this to the field you want to use for finding the document
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      // Update the found document
      await documentSnapshot.reference.update({
        'title': event.title,
        'description': event.description,
        'date': event.date.toString(),
        'time': event.time,
        'location': event.location,
        'category': event.category,
        'price': event.price,
        'availability': event.availability,
        // Add more fields if needed
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Event updated successfully!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print('No matching document found');
      // Handle scenario where no matching document is found
    }
  } catch (error) {
    print('Error updating event: $error');
    // Handle error, if any
  }
}



  @override
  void dispose() {
    // Dispose controllers when the page is disposed
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _availabilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Event'), // Edit Event page title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController, // Controller for title editing
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController, // Controller for description editing
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _dateController, // Controller for date editing
              decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            TextField(
              controller: _timeController, // Controller for time editing
              decoration: InputDecoration(labelText: 'Time'),
            ),
            TextField(
              controller: _locationController, // Controller for location editing
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _categoryController, // Controller for category editing
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _priceController, // Controller for price editing
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: _availabilityController, // Controller for availability editing
              decoration: InputDecoration(labelText: 'Availability'),
            ),
            ElevatedButton(
              onPressed: () async {

                    Event updated =Event(
                        title: _titleController.text.trim(),
                        description: _dateController.text.trim(),
                        date: DateTime.parse(_dateController.text.trim()), 
                        time: _timeController.text.trim(), 
                        location: _locationController.text.trim(), 
                        category: _categoryController.text.trim(), 
                        price: _priceController.text.trim(), 
                        availability: _availabilityController.text.trim(),
                        );
                    await updateEvent(updated);
              },
              child: const Text('Save Changes'), // Button to save changes
            ),
            const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the delete logic here
                      deleteEvent();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text(
                      'Delete Event',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

