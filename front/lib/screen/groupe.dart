import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_and_go/controllers/Trajit_provider.dart';
import 'package:go_and_go/screen/login.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavBar/nav_bar.dart';
import '../controllers/Cars_provider.dart';
import '../controllers/demande_provider.dart';
import '../models/response/trajitRes_Model.dart';
import '../services/helpers/Trajit_helper.dart';
import 'Regster2.dart';
import 'addTrajit.dart';

class groupe extends StatefulWidget {
  const groupe({Key? key}) : super(key: key);

  @override
  State<groupe> createState() => _groupeState();
}

class _groupeState extends State<groupe> {
  late int userId;
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
        userId = decodedToken['user'] ?? '';
      });
    }
  }

  int _pageIndex = 2;
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DemandeNotifier>(
      create: (_) => DemandeNotifier(),
      child: Consumer<DemandeNotifier>(
        builder: (context, demandeProvider, child) {
          return ChangeNotifierProvider<CarNotifier>(
            create: (_) => CarNotifier(),
            child: Consumer<CarNotifier>(
              builder: (context, carNotifier, child) {
                return ChangeNotifierProvider<TrajitNotifier>(
                  create: (_) => TrajitNotifier(),
                  child: Consumer<TrajitNotifier>(
                    builder: (context, trajitNotifier, child) {
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
                                    SizedBox(
                                        width:
                                            235), // Espace entre les deux images
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/chat1');
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
                                )),
                                FutureBuilder<List<TrajitModelRes>>(
                                  future: TrajitHalper
                                      .getAllRidesForTodayAndTomorrow(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(child: Column(
                                        children: [
                                          Text('Aucune donnee disponible ', style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF00AA9B),
                                          ),),
                                          Image.asset(
                                            'assets/img/Carsimage2.png',
                                            width: 298,
                                            height: 300,
                                            fit: BoxFit.contain, // Choose a fit option
                                          ),
                                        ],
                                      ));
                                    } else if (snapshot.hasData) {
                                      List<TrajitModelRes> rideList =
                                          snapshot.data!;
                                      return Container(
                                        height: 600,
                                        width: 360,
                                        child: ListView.builder(
                                          itemCount: rideList.length,
                                          itemBuilder: (context, index) {
                                            TrajitModelRes trajit =
                                                rideList[index];
                                            return Container(
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/img/profil.png',
                                                        fit: BoxFit.contain,
                                                        width: 72,
                                                        height: 55,
                                                      ),
                                                      Text(
                                                        ' ${trajit.creator.firstName}  ${trajit.creator.lastName}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0.07,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 30),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'De ',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.07,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${trajit.startLocation} ',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.07,
                                                            ),
                                                          ),
                                                          Text(
                                                            'à ',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.07,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' ${trajit.finalDestination}',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.07,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 20),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Places :',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.07,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' ${trajit.numberOfSeats}',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.07,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 25),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Jour :',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffFFFFFF),
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0.07,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${trajit.day} ',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.redAccent,
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0.07,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 25),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Heure : ',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0.07,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${trajit.goingOffTime}',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.redAccent,
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0.07,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xFF00AA9B),
                                                      foregroundColor:
                                                          Colors.white,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 16),
                                                    ),
                                                    onPressed: () {
                                                      print('usssssssssssssssssssssssssssser : $userId');
                                                        print(trajit.creator.id);
                                                      Provider.of<DemandeNotifier>(
                                                              context,
                                                              listen: false)
                                                          .addDemand(userId,
                                                              trajit.id)
                                                          .then((demandeReq) {
                                                        // La demande a été ajoutée avec succès
                                                        
                                                        // Affichez une popup pour informer l'utilisateur
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Demande envoyée avec succès'),
                                                              content: Text(
                                                                  'Votre demande a été enregistrée.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'OK'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }).catchError((error) {
                                                        // Une erreur s'est produite lors de l'ajout de la demande
                                                        // Affichez une popup d'erreur
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Erreur'),
                                                              content: Text(
                                                                  'Une erreur s\'est produite lors de l\'ajout de la demande.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'OK'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      });
                                                    },
                                                    child: Text(
                                                      'Demande',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      return Center(
                                          child: Text(
                                        'pas de Covoiturage',
                                      ));
                                    }
                                  },
                                ),
                                SizedBox(height: 200),
                              ],
                            ),
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
                              side: const BorderSide(
                                  width: 2, color: Colors.white),
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
              },
            ),
          );
        },
      ),
    );
  }
}
