import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
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
                        // const Expanded(
                        //   child: Padding(
                        //     padding: EdgeInsets.fromLTRB(24, 64, 24, 24),
                        //     child: Text(
                        //       'Join us & Enjoy our Events !',
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //         fontFamily: 'Poppins',
                        //         color: Colors.black,
                        //         fontSize: 28,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(60.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) {
                                  return Login();
                                },
                              ));
                            },
                            child: const Text(
                              'Get Started',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                    )),
              ),
            ])));
  }
}
