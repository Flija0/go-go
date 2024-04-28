import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = 'AIzaSyCF9bt22DOxcvUAAVd0k7t4s_qwAvksmCQ';

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);

    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results);
    return results;
  }

  Future<Map<String, dynamic>> getDirections(
      String origin, String destination) async {

    final String url =
        'http://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    if (json['routes'] != null && json['routes'].isNotEmpty) {
      var route = json['routes'][0]; // Get the first route
      if (route != null) {
        var bounds = route['bounds'];
        var legs = route['legs'];

        if (bounds != null && legs != null && legs.isNotEmpty) {
          var startLocation = legs[0]['start_location'];
          var endLocation = legs[0]['end_location'];
          var overviewPolyline = route['overview_polyline']['points'];

          // Decode polyline points
          var polylinePoints = PolylinePoints().decodePolyline(overviewPolyline);

          var results = {
            'bounds_ne': bounds['northeast'],
            'bounds_sw': bounds['southwest'],
            'start_location': startLocation,
            'end_location': endLocation,
            'polyline': overviewPolyline,
            'polyline_decoded': polylinePoints,
          };

          print(results);
          return results;
        }
      }
    }

    // Handle error case where expected data is not available
    throw Exception('$origin directions. $destination');
  }

}