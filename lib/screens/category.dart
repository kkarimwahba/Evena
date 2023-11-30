import 'package:evena/widgets/drawers.dart';
import 'package:evena/screens/userHome.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // final TextEditingController _searchControllerCategory =
  //     TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerWidget(
          title: 'Evena',
        ),
        appBar: AppBar(
          title: const Text(
            "EVENA",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 35.0, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) {
                            return const UserHome();
                          },
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 85,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.asset(
                                index == 0
                                    ? 'assets/images/musicIcon.png'
                                    : index == 1
                                        ? 'assets/images/standup.png'
                                        : index == 2
                                            ? 'assets/images/gamimg.png'
                                            : 'assets/images/gamimg.png',
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                index == 0
                                    ? "Musical"
                                    : index == 1
                                        ? "Stand-up Comedy"
                                        : index == 2
                                            ? "Gaming"
                                            : "Gaming",
                                style: const TextStyle(fontSize: 20),
                              ),
                              trailing: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
