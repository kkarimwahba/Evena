import 'package:evena/screens/eventdetails.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final TextEditingController _searchController = TextEditingController();

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
              itemCount: 6,
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
                          index == 0
                              ? 'assets/images/WhatsApp Image 2023-11-28 at 17.48.50_adfb07c2.jpg'
                              : index == 1
                                  ? 'assets/images/WhatsApp Image 2023-11-28 at 17.48.53_e935cf48.jpg'
                                  : index == 2
                                      ? 'assets/images/WhatsApp Image 2023-11-28 at 17.48.55_461f5362.jpg'
                                      : index == 3
                                          ? 'assets/images/WhatsApp Image 2023-11-28 at 17.48.55_70f603d1.jpg'
                                          : index == 4
                                              ? 'assets/images/WhatsApp Image 2023-11-28 at 20.50.09_bd46e3d6.jpg'
                                              : 'assets/images/WhatsApp Image 2023-11-28 at 20.50.10_77a42bb1.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                        Positioned(
                          bottom: 150,
                          left: 210,
                          child: Text(
                            index == 0
                                ? "Tamer Hossny"
                                : index == 1
                                    ? "Cairokee"
                                    : index == 2
                                        ? "The Elite"
                                        : index == 3
                                            ? "Amr Diab"
                                            : index == 4
                                                ? "Sharmoofers"
                                                : "Nina Kraviz",
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
                            index == 0
                                ? "SIDI ABDEL RAHMAN."
                                : index == 1
                                    ? "NEW ALAMEIN FESTIVAL."
                                    : index == 2
                                        ? "STAND UP COMEDY SHOW."
                                        : index == 3
                                            ? "FORMULA 1 QATAR AIRWAYS."
                                            : index == 4
                                                ? "NEW ALAMEIN FESTIVAL."
                                                : "Terra Solis.",
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
                            index == 0
                                ? "North Coast 14th July."
                                : index == 1
                                    ? "26 August."
                                    : index == 2
                                        ? "Soon..."
                                        : index == 3
                                            ? "Post Race Concert 06 October."
                                            : index == 4
                                                ? "02 September."
                                                : "December 15th.",
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
                            index == 0
                                ? "Egypt."
                                : index == 1
                                    ? "Egypt."
                                    : index == 2
                                        ? "Egypt."
                                        : index == 3
                                            ? "Qatar."
                                            : index == 4
                                                ? "Egypt."
                                                : "Dubai.",
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
                            index == 0
                                ? "1400 EGP."
                                : index == 1
                                    ? "600 EGP."
                                    : index == 2
                                        ? "200 EGP."
                                        : index == 3
                                            ? "250 QAR."
                                            : index == 4
                                                ? "400 EGP."
                                                : "350 UAE.",
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
