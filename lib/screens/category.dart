import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EVENA",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: const Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 35.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Welcome to EVENA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 35,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
