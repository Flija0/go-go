import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_and_go/screen/addTrajit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/request/car_model.dart';
import '../models/request/trajiReq_model.dart';
import '../models/response/Car_Modelresp.dart';

import '../models/response/trajitRes_Model.dart';
import '../services/Config.dart';
import '../services/helpers/Trajit_helper.dart';
import '../services/helpers/car_helper.dart';

class TrajitNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _firstTime = true;

  bool get firstTime => _firstTime;

  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  bool? _entrypoint;

  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }


  late Future<List<TrajitModelReq>> trajituser;

  List<TrajitModelReq> _trajit = [];

  List<TrajitModelReq> get trajit => _trajit;

  final TrajitFormKey = GlobalKey<FormState>();


  bool validateAndSave() {
    final form = TrajitFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  addRide(int userID, TrajitModelReq model) {
    TrajitHalper.addRides(userID, model).then((response) {
      if (response == 200) {
        Get.snackbar(
            "car successfully added", "Please Check y",

            icon: const Icon(Icons.safety_check));
      } else if (response != 200) {
        Get.snackbar("", "Please Check",

            backgroundColor: Color(0x74FFFFFF),
            icon: const Icon(Icons.bookmark_add));
      }
    });
  }

  static var client = http.Client();

  Future<TrajitModelReq> updateRide(TrajitModelReq ride, int rideId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.put(
      Uri.parse('http://10.0.2.2:3000/ride/update/$rideId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(ride.toJson()),
    );

    if (response.statusCode == 200) {
      return TrajitModelReq.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update ride');
    }
  }



  Future<void> deleteRide(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };


      var url = Uri.http(Config.apiUrl, '/ride/delete/$id');
      var response = await client.delete(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        print('Car deleted successfully');
      } else {
        throw Exception('Failed to delete car');
      }
    } catch (e) {
      print('Error deleting car: $e');
      throw Exception('Failed to delete car');
    }
  }

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
  Future<TrajitModelRes> getRideById(int rideId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final String apiUrl = 'http://10.0.2.2:3000/ride/get/$rideId';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',

      },
      // Assurez-vous que Ride a une méthode toJson() pour le sérialiser en JSON
    );

    if (response.statusCode == 200) {
      // Si la requête est réussie, renvoyer le trajet récupéré depuis la réponse
      return TrajitModelRes.fromJson(jsonDecode(response.body));
    } else {
      // Gérer les erreurs en cas d'échec de la requête
      throw Exception('Échec de la récupération du trajet');
    }
  }


}

