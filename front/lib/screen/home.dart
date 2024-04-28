import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_and_go/NavBar/nav_bar.dart';
import 'package:get/get.dart';
import 'package:go_and_go/screen/addTrajit.dart';
import 'package:go_and_go/screen/trajet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../controllers/Cars_provider.dart';
import '../models/response/Car_Modelresp.dart';
import 'Regster2.dart';
import 'groupe.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late String firstName = '';
  int _pageIndex = 0;
  void _navigateToPage(int index) {
    setState(() {
      _pageIndex = index;
    });

    // Navigate to specific route based on index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');

        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/addtrajet');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/groupe');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/parametres');
        break;
    }
  }

  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    debugPrint('decodedToken : $token');

    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      setState(() {
        firstName = decodedToken['firstName'] ?? '';
      });
    }
  }

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
                children: [
                  SizedBox(height: 80),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/savelive');
                        },
                        child: Container(
                          width: 35,
                          height: 39,
                          decoration: BoxDecoration(
                              // Définir la décoration de votre premier conteneur ici
                              ),
                          child: Image.asset(
                            'assets/img/leaf.png',
                            width: 35,
                            height: 39,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 235), // Espace entre les deux images
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/chat1');
                          // Mettez votre logique de navigation ici
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          child: Image.asset(
                            'assets/img/msg.png',
                            width: 48,
                            height: 48,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                    /*children:[
                /*Image.asset(
                  'assets/img/leaf.png',
                  width: 35,
                  height: 39,
                  fit: BoxFit.contain, // Choose a fit option
                ),*/
                SizedBox(width: 235),
                Image.asset(
                  'assets/img/arcticons_verizon-messages.png',
                  width: 48,
                  height: 48,
                  fit: BoxFit.contain, // Choose a fit option
                ),
              ],*/
                  )),
                  SizedBox(height: 25),
                  Container(
                    width: 277,
                    height: 51,
                    child: Column(
                      children: [
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(
                                    0xFF00AA9B), // Couleur par défaut du texte
                              ),
                              children: [
                                TextSpan(
                                  text: "Ça fait plaisir de vous revoir ",
                                ),
                                TextSpan(
                                  text:
                                      '${firstName.isNotEmpty ? firstName : ''} !',
                                  style: TextStyle(
                                    color: Color(
                                        0xFFF04641), // Couleur rouge pour "Go"
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Container(
                            width: 266,
                            height: 126,
                            decoration: ShapeDecoration(
                              color:
                                  Colors.white.withOpacity(0.10005555199999912),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27.03),
                              ),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors
                                    .transparent, // Rendre la couleur de fond transparente
                                onPrimary: Colors.white, // Couleur du texte
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27.03),
                                ),
                              ),
                              onPressed: () {
                                Get.offAll(groupe());

                              },
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/img/cherche1.png',
                                      fit: BoxFit.contain,
                                      width: 48,
                                      height: 48,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Trouver un Trajet',
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Image.asset(
                            'assets/img/Vision.png',
                            width: 180,
                            height: 262,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 64,
              width: 64,
              child: FloatingActionButton(
                backgroundColor: Colors.white.withOpacity(0.5),
                elevation: 0,
                onPressed: () async {
                  bool hasCar = await carNotifier.aCar();
                  print(hasCar);
                 
                    try {
                      if (hasCar) {
                        Get.offAll(addtrajit());
                      } else {
                         Get.snackbar(
                          "Aucune voiture",
                          "Veuillez ajouter une voiture",
                          backgroundColor: Colors.white38,
                          icon: const Icon(Icons.bookmark_add),
                        );
                        Get.offAll(resgstertwo());
                      }
                    } catch (e) {
                      
                      print(
                          "Erreur lors de la récupération des détails de la voiture : $e");
                      Get.snackbar(
                        "Erreur",
                        "Une erreur s'est produite. Veuillez réessayer.",
                        backgroundColor: Colors.red,
                        icon: const Icon(Icons.error),
                      );
                    }
                  
                },
                shape: StarBorder.polygon(
                  sides: 6,
                  side: const BorderSide(width: 2, color: Colors.white),
                  pointRounding: 0.3,
                ),
                /*RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Colors.green),
              borderRadius: BorderRadius.circular(15),
            ),*/
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            bottomNavigationBar: NavBar(
              pageIndex: _pageIndex,
              onTap: _navigateToPage,
            ),
          );
        },
      ),
    );
  }
}
