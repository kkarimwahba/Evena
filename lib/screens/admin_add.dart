import 'package:evena/models/events.dart';
import 'package:evena/services/eventServices.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
        backgroundColor: Colors.black,
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
              onPressed: () async {
                Event newEvent = Event(
                  title: eventNameController.text.trim(),
                  description: eventDescriptionController.text.trim(),
                  date: DateTime.parse(eventDateController.text.trim()),
                  time: eventTimeController.text.trim(),
                  location: eventLocationController.text.trim(),
                  category: eventCategoryController.text.trim(),
                  price: double.parse(eventPriceController.text.trim()),
                  image: 'cairokee.jpg',
                  availability:
                      int.parse(eventAvailabilityController.text.trim()),
                );

                EventService eventService = EventService();
                await eventService
                    .addEvent(newEvent.toJson() as Map<String, dynamic>);
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
