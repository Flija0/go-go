import 'dart:convert';

import 'package:http/http.dart' as https;

import 'package:shared_preferences/shared_preferences.dart';


import 'package:go_and_go/models/response/auth/login_res.dart';

import 'package:go_and_go/services/config.dart';

import '../../models/request/auth/login_model.dart';


class AuthHelper {
  static var client = https.Client();

  static Future<bool> login(LoginModelReq model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiUrl, Config.loginUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = loginResponseModelFromJson(response.body).jwtToken;
      print(token);

      await prefs.setString('token', token);

      await prefs.setBool('loggedIn', true);

      return true;
    } else {
      return false;
    }
  }
}
