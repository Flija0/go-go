import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/consumepation.dart';

class ConsumptionProvider extends ChangeNotifier {


  Future<List<ConsumptionModel>> getTopThreeSavedConsumers() async {
   /** final response = await http.get(Uri.parse('http://10.0.2.2:3000/consumption/topThreeSavedConsumers'));*/
    final String apiUrl = 'http://10.0.2.2:3000/consumption/topThreeSavedConsumers';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      // Assurez-vous que Ride a une méthode toJson() pour le sérialiser en JSON
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => ConsumptionModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch top three saved consumers');
    }
  }

  Future<int> getTotalConsumptionSaved() async {
    /**final response = await http.get(Uri.parse('http://10.0.2.2:3000/consumption/totalConsumptionSaved'));*/
    final String apiUrl = 'http://10.0.2.2:3000/consumption/totalConsumptionSaved';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      // Assurez-vous que Ride a une méthode toJson() pour le sérialiser en JSON
    );
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to fetch total consumption saved');
    }
  }
}