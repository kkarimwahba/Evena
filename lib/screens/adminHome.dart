import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/screens/adminEventUpdate.dart';
import 'package:evena/screens/admin_add.dart';
import 'package:evena/screens/adminprofile.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int selectedPage = 0;

  final _pageOptions = [AddEventPage(), Events(), AdminProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[selectedPage],
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  selectedPage = 0;
                });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  selectedPage = 1;
                });
              },
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  selectedPage = 2;
                });
              },
              icon: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Management'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No events available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var event = snapshot.data!.docs[index].data()
                  as Map<String, dynamic>;

                return EventCard(
                        imagePath: event['image'] ?? '',
                        title: event['title'] ?? '',
                        description: event['description'] ?? '',
                        date: DateTime.parse(event['date'] ?? ''),
                        time: event['time'] ?? '',
                        location: event['location'] ?? '',
                        category: event['category'] ?? '',
                        price: event['price']?.toString() ?? '',
                        availability: event['availability']?.toString() ?? '',
              );
            },
          );
        },
      ),
    );
  }
}
