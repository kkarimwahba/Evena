import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/Theme/theme_provider.dart';
import 'package:evena/Theme/themedata.dart';
import 'package:evena/screens/eventpage.dart';
import 'package:evena/widgets/drawers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.price,
    required this.availability,
    required this.imagePath,
  });
}

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFilter = false;
  String _selectedFilter = 'title';
  List<String> _searchHistory = [];

  List<Event> allEvents = [];
  List<Event> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  bool loading = false;

  void fetchEvents() async {
    try {
      setState(() {
        loading = true;
      });

      final snapshot =
          await FirebaseFirestore.instance.collection('events').get();

      DateTime currentDate = DateTime.now();

      setState(() {
        allEvents = List<Event>.from(snapshot.docs.map((doc) {
          var event = doc.data() as Map<String, dynamic>;

          final isFutureEvent =
              DateTime.parse(event['date'] ?? '').isAfter(currentDate);

          if (isFutureEvent) {
            return Event(
              title: event['title'] ?? '',
              description: event['description'] ?? '',
              date: DateTime.parse(event['date'] ?? ''),
              time: event['time'] ?? '',
              location: event['location'] ?? '',
              category: event['category'] ?? '',
              price: event['price']?.toString() ?? '',
              availability: event['availability']?.toString() ?? '',
              imagePath: event['image'] ?? '',
            );
          }

          return null;
        }).where((event) => event != null));

        filteredEvents = List<Event>.from(allEvents);

        loading = false;
      });
    } catch (error) {
      print('Error fetching events: $error');
    }
  }

  void applyFilters(String searchValue) {
    DateTime currentDate = DateTime.now();

    setState(() {
      _searchHistory.add(searchValue);

      filteredEvents = allEvents.where((event) {
        final filterValue = _getFilterValue(event);
        final containsValue = filterValue
            .toLowerCase()
            .contains(searchValue.trim().toLowerCase());

        final isFutureEvent = event.date.isAfter(currentDate);

        return containsValue && isFutureEvent;
      }).toList();
    });
  }

  String _getFilterValue(Event event) {
    switch (_selectedFilter) {
      case 'location':
        return event.location;
      case 'date':
        return event.date.toLocal().toString();
      case 'category':
        return event.category;
      case 'title':
      default:
        return event.title;
    }
  }

  void toggleFilter() {
    setState(() {
      _showFilter = !_showFilter;
    });

    if (_showFilter) {
      applyFilters(_searchController.text);
    }
  }

  void undoSearch() {
    _searchController.clear();
    applyFilters('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Color textColor =
        themeProvider.themeData == lightMode ? Colors.black : Colors.white;
    Color buttonColor = themeProvider.themeData == lightMode
        ? const Color.fromARGB(255, 255, 170, 0)
        : Colors.black;

    return Scaffold(
      drawer: DrawerWidget(
        title: 'Event Page',
      ),
      appBar: AppBar(
        title: const Text('Event List'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: toggleFilter,
          ),
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      applyFilters(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.undo),
                        onPressed: undoSearch,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showFilter)
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: [
                    DropdownMenuItem(
                      value: 'title',
                      child: Text('Title'),
                    ),
                    DropdownMenuItem(
                      value: 'location',
                      child: Text('Location'),
                    ),
                    DropdownMenuItem(
                      value: 'date',
                      child: Text('Date'),
                    ),
                    DropdownMenuItem(
                      value: 'category',
                      child: Text('Category'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                    });

                    applyFilters(_searchController.text);
                  },
                ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                var event = filteredEvents[index];

                return EventCard(
                  imagePath: event.imagePath,
                  title: event.title,
                  description: event.description,
                  date: event.date,
                  time: event.time,
                  location: event.location,
                  category: event.category,
                  price: event.price,
                  availability: event.availability,
                );
              },
            ),
          ),
        ],
      ),
    );
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
    return InkWell(
      onTap: () {
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
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (imagePath != null && imagePath.trim().isNotEmpty)
              Image.network(
                imagePath,
                fit: BoxFit.cover,
                height: 200,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 170, 0),
              ),
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Book Now!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
