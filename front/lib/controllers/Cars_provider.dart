import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/request/car_model.dart';
import '../models/response/Car_Modelresp.dart';

import '../services/helpers/car_helper.dart';

class CarNotifier extends ChangeNotifier {
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

  Future<void> loadCars() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        await CarHelper.getCars(token);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading cars: $e');
      // Handle error loading cars
    }
  }

  Future<bool> hasCar() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        List<CarModelResp> cars = (await CarHelper.getCars(token))
        as List<CarModelResp>; // Assuming getCars returns a list of cars
        bool userHasCars = cars.isNotEmpty;
        return userHasCars;
      }
      return false; // If token is null, assume user doesn't have cars
    } catch (e) {
      print('Error loading cars: $e');
      // Handle error loading cars
      return false; // Return false in case of any error
    }
  }

  late Future<List<CarModelResp>> caruser;

  List<CarModelReq> _cars = [];
  List<CarModelReq> get cars => _cars;

  final CarFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = CarFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  addCar(CarModelReq model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    CarHelper.addCar(model).then((response) {
      if (response == 200) {
        Get.snackbar("car successfully added", "Please Check y",
            icon: const Icon(Icons.safety_check));
      } else if (response != 200) {
        Get.snackbar("car successfully added", "Please Check",
            backgroundColor: Colors.red, icon: const Icon(Icons.bookmark_add));
      }
    });
  }

  Future<CarModelResp> getCar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      return await CarHelper.getCars(token);
    } else {
      throw Exception("Token not found");
    }
  }

  Future<bool> aCar() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        CarModelResp? car = await CarHelper.getCars(token);

        if (car != null) {
          return true; // User has a car
        } else {
          return false; // User does not have a car
        }
      } else {
        throw Exception("Token not found");
      }
    } catch (e) {
      print('Error checking car status: $e');
      // Handle the error (e.g., log, show error message)
      return false; // Return false in case of any error
    }
  }

  Future<void> deleteCar(int carId, String jwtToken) async {
    try {
      await CarHelper.deleteCar(carId, jwtToken);
      // Mettre à jour la liste des voitures après suppression
      // par exemple, vous pouvez appeler une méthode pour recharger les voitures
      loadCars(); // Assurez-vous d'implémenter loadCars pour charger les voitures à nouveau
      notifyListeners(); // Notifie les écouteurs de changement
    } catch (e) {
      print('Error deleting car: $e');
      // Gérer les erreurs de suppression ici
    }
  }
}