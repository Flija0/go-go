import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_and_go/controllers/Cars_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response/Car_Modelresp.dart';
import '../services/helpers/car_helper.dart';
import 'home.dart';

class Car extends StatefulWidget {
  const Car({Key? key}) : super(key: key);

  @override
  State<Car> createState() => _CarState();
}

class _CarState extends State<Car> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CarNotifier>(
      create: (_) => CarNotifier(),
      child: Consumer<CarNotifier>(
        builder: (context, carNotifier, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/logo1.png',
                    fit: BoxFit.contain,
                    width: 72,
                    height: 55,
                  ),
                ],
              ),
            ),
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF232D4B), Color(0xFF005573)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  FutureBuilder<CarModelResp>(
                    future: carNotifier.getCar(), // Appeler la méthode pour récupérer une voiture
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Afficher un indicateur de chargement pendant le chargement des données
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // Gérer les erreurs de chargement des données
                        return Center(child: Text('Aucune voiture disponible (-_-)', style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00AA9B),
                        ),));
                      } else if (snapshot.hasData) {
                        // Afficher les détails de la voiture une fois les données chargées
                        CarModelResp car = snapshot.data!;
                        return Container(
                          width: 323,
                          height: 350,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/votreV.png',
                              width: 90,
                              height: 90,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 71, height: 24),
                            Text(
                              'Modèle: ${car.brand}',
                              style: TextStyle(
                                fontSize: 20,
                                height: 18.75 / 15, // Calcul de la hauteur de ligne adaptative
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(width: 151, height: 24),
                            Text(
                              'Serie: ${car.serialNumber}',
                              style: TextStyle(
                                fontSize: 20,
                                height: 18.75 / 15, // Calcul de la hauteur de ligne adaptative
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(width: 71, height: 24),
                            Text(
                              'Co2: ${car.power}',
                              style: TextStyle(
                                fontSize: 20,
                                height: 18.75 / 15, // Calcul de la hauteur de ligne adaptative
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(height: 10), // Espacement entre le texte "Énergie" et les boutons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(1),
                                  width: 136,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Couleur de fond du bouton "Supprimer"
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      String? token = prefs.getString('token');

                                      debugPrint('decodedToken : $token');
                                      print(car.id);
                                      CarHelper.deleteCar(car.id, '$token');
                                      Get.offAll(home());
                                    },
                                    child: Text(
                                      'Supprimer',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFF04641),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                      } else {
                        return Center(
                            child: Text('Aucune donnée de voiture disponible'));
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 120,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF005573), Color(0xFF00AA9B)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Rendre la couleur de fond transparente
                        onPrimary: Colors.white, // Couleur du texte
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        // Action à exécuter lorsque le bouton "Commencer" est pressé
                        Get.offAll(home());
                      },
                      child: Center(
                        child: Text(
                          'Retour',
                          style: TextStyle(
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black38,
                                offset: Offset(-5.0, 5.0),
                              ),
                            ],
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}