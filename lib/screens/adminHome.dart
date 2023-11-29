import 'package:flutter/material.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Event Management'),
            SizedBox(width: 150),
            CircleAvatar(),
          ],
        ),
      ),
      body: 
        ListView.builder(
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
        bottomNavigationBar: Container( 
        height: 60, 
        decoration: BoxDecoration( 
          color: Colors.black, 
          borderRadius: const BorderRadius.only( 
            topLeft: Radius.circular(20), 
            topRight: Radius.circular(20), 
          ), 
        ), 
        child: Row( 
          mainAxisAlignment: MainAxisAlignment.spaceAround, 
          children: [ 
            IconButton( 
              enableFeedback: false, 
              onPressed: () {}, 
              icon: const Icon( 
                Icons.home_outlined, 
                color: Colors.white, 
                size: 35, 
              ), 
            ),  
            IconButton( 
              enableFeedback: false, 
              onPressed: () {}, 
              icon: const Icon( 
                Icons.add, 
                color: Colors.white, 
                size: 35, 
              ), 
            ), 
            IconButton( 
              enableFeedback: false, 
              onPressed: () {}, 
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
