import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDescriptionController = TextEditingController();
  TextEditingController _eventDateController = TextEditingController();
  TextEditingController _eventPriceController = TextEditingController();

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    _eventDateController.dispose();
    _eventPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _eventNameController,
              decoration: InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _eventDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Event Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _eventDateController,
                    decoration: InputDecoration(
                      labelText: 'Event Date',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                         
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _eventPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price (\$)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String eventName = _eventNameController.text;
                String eventDescription = _eventDescriptionController.text;
                String eventDate = _eventDateController.text;
                String eventPrice = _eventPriceController.text;
              },
              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}