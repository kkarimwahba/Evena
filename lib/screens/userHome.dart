import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/screens/eventpage.dart';
import 'package:evena/widgets/drawers.dart';
import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final String price;
  final String availability;
  final String imagePath;

  Event(
      {required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.location,
      required this.category,
      required this.price,
      required this.availability,
      required this.imagePath});
}

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final TextEditingController _searchController = TextEditingController();

  List<Event> allEvents = [];
  List<Event> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  void fetchEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('events').get();

    setState(() {
      allEvents = snapshot.docs.map((doc) {
        var event = doc.data() as Map<String, dynamic>;
        return Event(
          title: event['title'] ?? '',
          description: event['description'] ?? '',
          date: DateTime.parse(event['date'] ?? ''),
          time: event['time'] ?? '',
          location: event['location'] ?? '',
          category: event['category'] ?? '',
          price: event['price']?.toString() ?? '',
          availability: event['availability']?.toString() ?? '',
          imagePath: event['imagepath'] ?? '',

          // Add image field if stored in Firestore
        );
      }).toList();

      // Initialize the filteredEvents list with all events initially
      filteredEvents = List.from(allEvents);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// <<<<<<< ticketDesign
//         drawer: DrawerWidget(
//           title: 'Event Page',
//         ),
//         appBar: AppBar(
//           title: const Text('Event List'),
//         ),
//         body: Column(
//           children: [
//             SizedBox(
//               width: 1 * MediaQuery.of(context).size.width,
//               child: TextField(
//                 controller: searchController,
//                 onChanged: (value) {
//                   // Update the filteredEvents list when the user types in the search bar
//                   setState(() {
//                     filteredEvents = allEvents
//                         .where((event) =>
//                             event.title
//                                 .toLowerCase()
//                                 .contains(value.toLowerCase()) ||
//                             event.category
//                                 .toLowerCase()
//                                 .contains(value.toLowerCase()) ||
//                             event.time
//                                 .toLowerCase()
//                                 .contains(value.toLowerCase()))
//                         .toList();
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: "Search",
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
// =======
        drawer: DrawerWidget(
          title: 'Event Page',
        ),
        appBar: AppBar(
          title: const Text('Event List'),
        ),
        body: Column(
          children: [
            SizedBox(
              width: 0.9 * MediaQuery.of(context).size.width,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  // Update the filteredEvents list when the user types in the search bar
                  setState(() {
                    filteredEvents = allEvents
                        .where((event) =>
                            event.title
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            event.category
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            event.time
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            (event.imagePath?.toLowerCase() ?? '')
                                .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search by : Location, Time, Cost.",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('events').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No events available.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var event = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      DateTime eventDate = DateTime.parse(event['date'] ?? '');

                      // Check if the event date is in the future
                      if (eventDate.isAfter(DateTime.now())) {
                        return EventCard(
                          imagePath: event['image'] ?? '',
                          title: event['title'] ?? '',
                          description: event['description'] ?? '',
                          date: eventDate,
                          time: event['time'] ?? '',
                          location: event['location'] ?? '',
                          category: event['category'] ?? '',
                          price: event['price']?.toString() ?? '',
                          availability: event['availability']?.toString() ?? '',
                        );
                      } else {
                        // Event date is in the past, so don't display it
                        return SizedBox
                            .shrink(); // Empty SizedBox to make it invisible
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final String price;
  final String imagePath;
  final String availability;

  EventCard({
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
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imagePath,
            fit: BoxFit.cover,
            height: 200, // Set the desired height
          ),
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
            subtitle: Text('Price: $price EGP'),
          ),
          ListTile(
            title: Text('Availability: $availability'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsPage(
                    title: title,
                    description: description,
                    date: date,
                    time: time,
                    location: location,
                    category: category,
                    price: price,
                    imagePath: imagePath,
                    availability: availability,
                  ),
                ),
              );
            },
            child: const Text('Book Now!'),
          ),
        ],
      ),
    );
  }
}
