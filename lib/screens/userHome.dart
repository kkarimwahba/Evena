import 'package:evena/screens/eventdetails.dart';
import 'package:flutter/material.dart';

class Event {
  final String name;
  final String location;
  final String date;
  final String country;
  final String cost;
  final String imagePath;

  Event(this.name, this.location, this.date, this.country, this.cost,
      this.imagePath);
}

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final TextEditingController _searchController = TextEditingController();
  List<Event> allEvents = [
    Event(
        "Tamer Hossny",
        "SIDI ABDEL RAHMAN",
        "North Coast 14th July.",
        "Egypt.",
        "1400 EGP.",
        'assets/images/WhatsApp Image 2023-11-28 at 17.48.50_adfb07c2.jpg'),
    Event(
        "Cairokee",
        "NEW ALAMEIN FESTIVAL",
        "26 August.",
        "Egypt.",
        "600 EGP.",
        'assets/images/WhatsApp Image 2023-11-28 at 17.48.53_e935cf48.jpg'),
    Event("The Elite", "STAND UP COMEDY SHOW", "Soon...", "Egypt.", "200 EGP.",
        'assets/images/WhatsApp Image 2023-11-28 at 17.48.55_461f5362.jpg'),
    Event(
        "Amr Diab",
        "FORMULA 1 QATAR AIRWAYS",
        "Post Race Concert 06 October.",
        "Qatar.",
        "250 QAR.",
        'assets/images/WhatsApp Image 2023-11-28 at 17.48.55_70f603d1.jpg'),
    Event(
        "Sharmoofers",
        "NEW ALAMEIN FESTIVAL",
        "02 September.",
        "Egypt.",
        "400 EGP.",
        'assets/images/WhatsApp Image 2023-11-28 at 20.50.09_bd46e3d6.jpg'),
    Event("Nina Kraviz", "Terra Solis", "December 15th.", "Dubai.", "350 UAE.",
        'assets/images/WhatsApp Image 2023-11-28 at 20.50.10_77a42bb1.jpg'),
  ];

  List<Event> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    // Initialize the filteredEvents list with all events initially
    filteredEvents = List.from(allEvents);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "EVENA",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 35.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Explore Our Events.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 0.9 * MediaQuery.of(context).size.width,
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // Update the filteredEvents list when the user types in the search bar
                setState(() {
                  filteredEvents = allEvents
                      .where((event) =>
                          event.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          event.location
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          event.country
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          event.cost
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) {
                        return EventDetails();
                      },
                    ));
                  },
                  child: Card(
                    shadowColor: const Color.fromARGB(230, 255, 176, 17),
                    elevation: 4,
                    margin: const EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Image.asset(
                          filteredEvents[index].imagePath,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                        Positioned(
                          bottom: 150,
                          left: 210,
                          child: Text(
                            filteredEvents[index].name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Positioned(
                          bottom: 120,
                          left: 200,
                          child: Text(
                            filteredEvents[index].location,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Positioned(
                          bottom: 100,
                          left: 200,
                          child: Text(
                            filteredEvents[index].date,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          left: 200,
                          child: Text(
                            filteredEvents[index].country,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Positioned(
                          bottom: 60,
                          left: 200,
                          child: Text(
                            filteredEvents[index].cost,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 0, right: 0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) {
                                    return EventDetails();
                                  },
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(230, 255, 176, 17),
                              ),
                              child: const Text(
                                "Event Details",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
