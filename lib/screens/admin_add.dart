import 'dart:io';

import 'package:evena/models/events.dart';
import 'package:evena/services/eventServices.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventPriceController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventCategoryController = TextEditingController();
  TextEditingController eventAvailabilityController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();
  File? _pickedImage;
  String _imageUrl = '';
  @override
  void dispose() {
    eventNameController.dispose();
    eventDescriptionController.dispose();
    eventDateController.dispose();
    eventPriceController.dispose();
    eventLocationController.dispose();
    eventCategoryController.dispose();
    eventAvailabilityController.dispose();
    eventTimeController.dispose();
    super.dispose();
  }

  // Function to pick an image from the gallery
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: eventNameController,
              decoration: const InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: eventDescriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Event Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: eventLocationController,
              decoration: const InputDecoration(
                labelText: 'Event Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: eventTimeController,
              decoration: const InputDecoration(
                labelText: 'Event time',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: eventCategoryController,
              decoration: const InputDecoration(
                labelText: 'Event category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: eventAvailabilityController,
              decoration: const InputDecoration(
                labelText: 'Event Availability',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: eventDateController,
                    decoration: InputDecoration(
                      labelText: 'Event Date',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: eventPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Price (\$)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickImageFromGallery,
              child: Text('Pick Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Call the function to pick an image from the gallery
                await pickImageFromGallery();

                // If an image is picked, upload it to Firebase Storage
                String? imageUrl = await uploadImageToStorage();

                // If image upload is successful, update the URL and proceed to add the event
                if (imageUrl != null) {
                  setState(() {
                    _imageUrl = imageUrl;
                  });

                  Event newEvent = Event(
                    title: eventNameController.text.trim(),
                    description: eventDescriptionController.text.trim(),
                    date: DateTime.parse(eventDateController.text.trim()),
                    time: eventTimeController.text.trim(),
                    location: eventLocationController.text.trim(),
                    category: eventCategoryController.text.trim(),
                    price: double.parse(eventPriceController.text.trim()),
                    image: imageUrl,
                    availability:
                        int.parse(eventAvailabilityController.text.trim()),
                    imagePath: null,
                  );

                  EventService eventService = EventService();
                  await eventService
                      .addEvent(newEvent.toJson() as Map<String, dynamic>);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent[700],
              ),
              child: const Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}
