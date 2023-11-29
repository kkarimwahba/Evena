import 'package:evena/screens/Booking.dart';
import 'package:flutter/material.dart';


class Eventdetails extends StatefulWidget {
  Eventdetails({Key? key}) : super(key: key);

  @override
  _EventdetailsState createState() => _EventdetailsState();
}

class _EventdetailsState extends State<Eventdetails> {

// final TextEditingController _searchControllerCategory =
//       TextEditingController();

//  @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

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
          // SizedBox(
          //   width: 0.9 * MediaQuery.of(context).size.width,
          //   child: TextField(
          //     // controller: _searchController,
          //     decoration: InputDecoration(
          //       hintText: "Search",
          //       prefixIcon: const Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () { Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) {
                                    return Booking();
                                  },
                                ));},
                  child: Card(
                    shadowColor: const Color.fromARGB(230, 255, 176, 17),
                    elevation: 4,
                    margin: const EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Image.asset(
                          'assets/images/WhatsApp Image 2023-11-28 at 17.48.50_adfb07c2.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                        const Positioned(
                          bottom: 150,
                          left: 210,
                          child: Text(
                             "Tamer Hossny",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const Positioned(
                          bottom: 120,
                          left: 200,
                          child: Text(
                             "SIDI ABDEL RAHMAN.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const Positioned(
                          bottom: 100,
                          left: 200,
                          child: Text(
                             "North Coast 14th July.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const Positioned(
                          bottom: 80,
                          left: 200,
                          child: Text(
                             "Egypt.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const Positioned(
                          bottom: 60,
                          left: 200,
                          child: Text(
                             "1400 EGP.",
                            style: TextStyle(
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
                                    return Booking();
                                  },
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(230, 255, 176, 17),
                              ),
                              child: const Text(
                                "Book Now",
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