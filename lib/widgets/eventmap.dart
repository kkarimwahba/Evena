// import 'dart:js';
// import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PickedLocation {
//   final String displayName;
//   final LatLng latLng;

//   PickedLocation({
//     required this.displayName,
//     required this.latLng,
//   });
// }

// class Mappage extends StatelessWidget {
//   const Mappage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Page'),
//       ),
//       body: OpenStreetMapSearchAndPick(
//         center: const LatLong(30.0626, 31.2195),
//         buttonColor: Colors.blue,
//         buttonText: 'Select Location',
//         onPicked: (PickedData pickedData) async {
//           print('Selected Location: ${pickedData.displayName}');
//           print('Latitude: ${pickedData.latLong.latitude}');
//           print('Longitude: ${pickedData.latLong.longitude}');

//           // Convert PickedData to PickedLocation if needed
//           PickedLocation pickedLocation = PickedLocation(
//             displayName: pickedData.displayName,
//             latLng: pickedData.latLng,
//           );

//           // Store the selected location in Firebase
//           await storeLocationInFirebase(pickedLocation);
//         },
//       ),
//     );
//   }

//   Future<void> storeLocationInFirebase(PickedLocation pickedData) async {
//     try {
//       // Access Firestore instance
//       FirebaseFirestore firestore = FirebaseFirestore.instance;

//       // Create a new document in a 'locations' collection
//       await firestore.collection('locations').add({
//         'name': pickedData.displayName,
//         'latitude': pickedData.latLng.latitude,
//         'longitude': pickedData.latLng.longitude,
//       });

//       // Show a success message
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//         const SnackBar(
//           content: Text('Location stored successfully in Firebase!'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     } catch (error) {
//       // Handle error, if any
//       print('Error storing location: $error');
//     }
//   }
// }
