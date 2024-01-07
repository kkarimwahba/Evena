

import 'package:url_launcher/url_launcher.dart';

class MapLoc{
  MapLoc._();
  static Future<void> openMap(double latitude, double longitude) async {
    try {
      Uri googleMapUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

      if (await canLaunch(googleMapUrl.toString())) {
        await launch(googleMapUrl.toString());
      } else {
        throw 'Could not launch map';
      }
    } catch (e) {
      print('Error opening map: $e');
      throw 'Failed to open map';
    }
  }
}