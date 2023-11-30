import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  const Events ({super.key});
  

  @override
  Widget build(BuildContext context) {
    final _controller = ScrollController();

    return Scaffold(
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