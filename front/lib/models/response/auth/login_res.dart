import 'dart:convert';

import 'package:flutter/foundation.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {

  final String jwtToken;

  LoginResponseModel({

    required this.jwtToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(

        jwtToken: json["jwtToken"],

      );

  Map<String, dynamic> toJson() => {

    "jwtToken": jwtToken,
  };

}