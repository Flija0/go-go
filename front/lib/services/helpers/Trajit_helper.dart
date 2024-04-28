import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/request/car_model.dart';
import '../../models/request/trajiReq_model.dart';
import '../../models/response/trajitRes_Model.dart';
import '../Config.dart';
import 'package:go_and_go/models/response/Car_Modelresp.dart';

class TrajitHalper extends ChangeNotifier {


  static var client = http.Client();

  static Future<TrajitModelReq> addRides(int userId, TrajitModelReq ride) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final String apiUrl = 'http://10.0.2.2:3000/ride/add/$userId';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',

      },
      body: jsonEncode(ride.toJson()), // Assurez-vous que Ride a une méthode toJson() pour le sérialiser en JSON
    );
    if (response.statusCode == 200) {
      // Si la requête est réussie, renvoyer le trajet ajouté depuis la réponse
      return TrajitModelReq.fromJson(jsonDecode(response.body));
    } else {
      // Gérer les erreurs en cas d'échec de la requête
      throw Exception('Échec de l\'ajout du trajet');
    }
  }



  Future<TrajitModelReq> updateRide(TrajitModelReq ride, int rideId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final String apiUrl = '10.0.2.2:3000/ride/update/$rideId';

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(ride.toJson()), // Assurez-vous que Ride a une méthode toJson() pour le sérialiser en JSON
    );

    if (response.statusCode == 200) {
      // Si la requête est réussie, renvoyer le trajet mis à jour depuis la réponse
      return TrajitModelReq.fromJson(jsonDecode(response.body));
    } else {
      // Gérer les erreurs en cas d'échec de la requête
      throw Exception('Échec de la mise à jour du trajet');
    }
  }

  Future<void> deleteRide(int rideId) async {
    final String apiUrl = '10.0.2.2:3000/ride/delete/$rideId';

    final response = await http.delete(Uri.parse(apiUrl));

    if (response.statusCode != 200) {
      // Gérer les erreurs en cas d'échec de la requête DELETE
      throw Exception('Échec de la suppression du trajet');
    }
  }

  static const String baseUrl = 'http://10.0.2.2:3000'; // Remplacez par l'URL de votre API

  static Future<List<TrajitModelRes>> getAllRidesForTodayAndTomorrow() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final String apiUrl = 'http://10.0.2.2:3000/ride/getAllRidesForTodayAndTomorrow';
     // Replace with your API endpoint

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',

        },
         // Assurez-vous que Ride a une méthode toJson() pour le sérialiser en JSON
      );

      if (response.statusCode == 200) {
        // Convert the JSON response into a list of TrajitModelRes objects
        List<dynamic> rideListJson = jsonDecode(response.body);
        List<TrajitModelRes> rideList = rideListJson
            .map((json) => TrajitModelRes.fromJson(json))
            .toList();
        return rideList;
      } else {
        throw Exception('Failed to load rides: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  /*static Future<TrajitModelRes> getRides() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.http(Config.apiUrl, Config.getAllRidesForTodayAndTomorrow);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var rides = trajitModelResToJson(response.body as TrajitModelRes);
      return rides;
    } else {
      throw Exception("Failed to get the Car");
    }
  }*/
}