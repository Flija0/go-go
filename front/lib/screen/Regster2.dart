import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_and_go/screen/Regster1.dart';
import 'package:provider/provider.dart';
import '../controllers/Cars_provider.dart';
import '../models/request/car_model.dart';
import 'Regster3.dart';
import 'home.dart';

class resgstertwo extends StatefulWidget {
  const resgstertwo({Key? key}) : super(key: key);

  @override
  State<resgstertwo> createState() => _resgstertwoState();
}

class _resgstertwoState extends State<resgstertwo> {
  final TextEditingController power = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController serialNumber = TextEditingController();
  final TextEditingController photo = TextEditingController();

  @override
  void dispose() {
    power.dispose();
    brand.dispose();
    serialNumber.dispose();
    photo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CarNotifier>(
      create: (_) => CarNotifier(),
      child: Consumer<CarNotifier>(
        builder: (context, carNotifier, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF232D4B), Color(0xFF005573)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/img/Carsimage2.png',
                            width: 298,
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: "Inscrivez-vous pour Commencer !",
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 360,
                          height: 44,
                          child: Text(
                            "Information sur les Voitures",
                            style: const TextStyle(
                              fontFamily: "Gilroy",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFF04641),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: carNotifier.CarFormKey,
                      child: Column(
                        children: [
                          Container(
                            width: 311,
                            height: 48,
                            child: TextFormField(
                              controller: brand,
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Le champ Modèle ne doit pas être vide';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Modèle",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Ajuster la taille du champ de saisie
                                filled: true,
                                fillColor: Color(0xFFFCFFFD),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder( // Définir le style de la bordure quand le champ n'est pas en focus
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: BorderSide(color: Color(0xFFFCFFFD), width: 2),

                                ),
                                prefixIcon: Icon(Icons.directions_car,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: 311,
                            height: 48,
                            child: TextFormField(
                              controller: serialNumber,
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Le champ Série ne doit pas être vide';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Série N° *** Tn ***",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Ajuster la taille du champ de saisie
                                filled: true,
                                fillColor: Color(0xFFFCFFFD),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder( // Définir le style de la bordure quand le champ n'est pas en focus
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: BorderSide(color: Color(0xFFFCFFFD), width: 2),
                                ),
                                prefixIcon: Icon(Icons.code, color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: 311,
                            height: 48,
                            child: TextFormField(
                              controller: power,
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Le champ Énergie ne doit pas être vide';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Émission de CO2",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Color(0xFFFCFFFD),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFCFFFD),
                                    width: 2,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.co2, color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: 150,
                            height: 100,
                            /*child: TextFormField(
                              controller: photo,
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Le champ image ne doit pas être vide';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "photo de la voiture",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Color(0xFFFCFFFD),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFCFFFD),
                                    width: 2,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.photo, color: Colors.grey),
                              ),
                            ),*/
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 48,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFFF52), Color(0xFF7400)],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),// Couleur de fond du bouton "Skip"
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent, // Rendre la couleur de fond transparente
                                    onPrimary: Color(0xFFF00AA9B), // Couleur du texte
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Action à exécuter lorsque le bouton "Skip" est pressé
                                    Get.offAll(regseterone());
                                  },
                                  child: Center(
                                    child: Text(
                                      'Précé',
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
                              SizedBox(width:110, height: 16), // Espacement entre les boutons
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
                                    if (carNotifier.validateAndSave()) {
                                      CarModelReq model = CarModelReq(
                                        power: int.parse(power.text),
                                        brand: brand.text,
                                        serialNumber: serialNumber.text,
                                        photo: "photo",
                                      );
                                      carNotifier.addCar(model);
                                      debugPrint('Car Saved $CarModelReq');
                                      Get.offAll(regsterthree());
                                    } else {
                                      Get.defaultDialog(
                                        title: 'Erreur',
                                        middleText:
                                        'Le champ Émission de CO2 ne doit pas être vide.',
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'Suivant',
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
                          SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
/*onPressed: () {
                                  Get.offAll(regseterone());
                                },



                                onPressed: () {
                                  if (carNotifier.validateAndSave()) {
                                    CarModelReq model = CarModelReq(
                                      power: int.parse(power.text),
                                      brand: brand.text,
                                      serialNumber: serialNumber.text,
                                      photo: photo.text,
                                    );
                                    carNotifier.addCar(model);
                                    debugPrint('Car Saved $CarModelReq');
                                    //Get.offAll(regsterthree());
                                  } else {
                                    Get.defaultDialog(
                                      title: 'Erreur',
                                      middleText:
                                      'Le champ Émission de CO2 ne doit pas être vide.',
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  }
                                },*/