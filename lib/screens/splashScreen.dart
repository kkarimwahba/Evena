import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(children: [
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset('assets/images/.jpg').image,
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: const AlignmentDirectional(0, 1),
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) {
                                  return Login();
                                },
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 150, 0, 220),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(24, 64, 24, 10),
                                child: Text(
                                  'Discover exciting events near you.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Explore a wide range of events and activites.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      )),
                ),
              ]))),
    );
  }
}
