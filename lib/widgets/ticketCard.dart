import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class TicketCard extends StatefulWidget {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String category;
  final String price;
  final String imagePath;
  final String availability;

  const TicketCard({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.availability,
  }) : super(key: key);

  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  GlobalKey globalKey = GlobalKey();

  Future<void> saveTicketToGallery() async {
    if (!mounted) return;

    RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    if (boundary == null) {
      // Handle the case where boundary is null
      return;
    }

    final image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    if (byteData != null) {
      Uint8List uint8List = byteData.buffer.asUint8List();
      await ImageGallerySaver.saveImage(uint8List);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.amberAccent[700],
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Your Ticket',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Text(
                "Thank your for purchase! \nSave your ticket below",
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TicketWidget(
                width: 300,
                height: 500,
                isCornerRounded: true,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 220, 147, 0),
                            radius: 60,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 55,
                              backgroundImage:
                                  AssetImage('assets/images/logo.png'),
                            ),
                          ),
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Text(
                                widget.location,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 170, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ticketDetails('Time', widget.time),
                                  ticketDetails('Price', widget.price),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     ticketDetails('Time', '8:30PM'),
                              //     ticketDetails('Price', '500\$'),
                              //   ],
                              // ),
                            ],
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.black,
                            child: Image.asset('assets/images/qrcode.png'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 40,
                width: 140,
                child: ElevatedButton(
                  onPressed: saveTicketToGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 200, 0), fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }

  Widget ticketDetails(String title, String details) => Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 20,
            width: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade200,
            ),
            child: Text(
              details,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}
