// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapSelectionPage extends StatefulWidget {
//   @override
//   _MapSelectionPageState createState() => _MapSelectionPageState();
// }

// class _MapSelectionPageState extends State<MapSelectionPage> {
//   Completer<GoogleMapController> _controller = Completer();
//   LatLng? _pickedLocation;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Location on Map'),
//       ),
//       body: GoogleMap(
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//         onTap: (LatLng location) {
//           setState(() {
//             _pickedLocation = location;
//           });
//         },
//         markers: _pickedLocation != null
//             ? {
//                 Marker(
//                   markerId: MarkerId('picked_location'),
//                   position: _pickedLocation!,
//                 ),
//               }
//             : {},
//         initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pop(context, _pickedLocation);
//         },
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }
