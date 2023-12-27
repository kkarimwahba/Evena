import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class Mappage extends StatefulWidget {
  const Mappage({Key? key}) : super(key: key);

  @override
  _MappageState createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  List<LatLong> pickedLocations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: OpenStreetMapSearchAndPick(
              center: pickedLocations.isEmpty
                  ? LatLong(30.0626, 31.2195) // Al Manara coordinates
                  : pickedLocations.last,
              buttonColor: Colors.blue,
              buttonText: 'Add Location',
              onPicked: (pickedData) {
                setState(() {
                  pickedLocations.add(pickedData.latLong);
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pickedLocations.length,
              itemBuilder: (context, index) {
                final location = pickedLocations[index];
                return ListTile(
                  title: Text('Location $index'),
                  subtitle: Text(
                      'Lat: ${location.latitude}, Lng: ${location.longitude}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the list of picked locations
          for (var location in pickedLocations) {
            print('Picked Location: $location');
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
