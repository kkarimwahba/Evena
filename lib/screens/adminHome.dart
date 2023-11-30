import 'package:evena/screens/admin_add.dart';
import 'package:evena/screens/adminprofile.dart';
import 'package:evena/screens/eventslist.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int selectedPage = 0;

  final _pageOptions = [Events(), AddEventPage(), AdminProfilePage()];

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
                Icons.home_outlined,
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
                Icons.add,
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
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Event Management'),
            SizedBox(width: 150),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: 3,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 130,
            child: Card(
              elevation: 10,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/startBK.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(75.0),
                        ),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
