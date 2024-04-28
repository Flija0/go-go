import 'package:flutter/material.dart';
import 'package:go_and_go/NavBar/nav_bar.dart';
import 'package:go_and_go/screen/parametres.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/Cars_provider.dart';
import '../controllers/Trajit_provider.dart';
import '../controllers/demande_provider.dart';
import '../models/response/DemandeRes.dart';
import '../models/response/trajitRes_Model.dart';
import 'Chat/chat_list_screen.dart';
import 'Regster2.dart';
import 'addTrajit.dart';
import 'groupe.dart';
import 'home.dart';


class trajet extends StatefulWidget {
  const trajet({Key? key}) : super(key: key);

  @override
  State<trajet> createState() => _trajetState();
}

class _trajetState extends State<trajet> {
  late int userId;

  @override
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
        userId = decodedToken['user'] ?? 0; // Assurez-vous que la valeur par défaut est compatible avec le type de userId
      });
    } else {
      // Gérer le cas où le jeton est null
      // Par exemple, vous pourriez rediriger l'utilisateur vers l'écran de connexion
    }
  }
// Rest of your code...


  int _pageIndex = 1;
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
        builder: (context, demandeNotifier, child) {
    return ChangeNotifierProvider<TrajitNotifier>(
        create: (_) => TrajitNotifier(),
        child: Consumer<TrajitNotifier>(
        builder: (context, trajitNotifier, child) {
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
      body: SingleChildScrollView(
    child: Column(
    children: [
      Container(

        height: 1000,
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
                        Navigator.of(context).pushReplacementNamed('/savelive');
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
                )
            ),

            SizedBox(height: 25),

            FutureBuilder<TrajitModelRes>(

              future: trajitNotifier.getRideById(userId), // Appeler la méthode pour récupérer une voiture
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Afficher un indicateur de chargement pendant le chargement des données
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Gérer les erreurs de chargement des données
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
                  // Afficher les détails de la voiture une fois les données chargées
                  TrajitModelRes rides = snapshot.data!;
                  return Container(
                    width: 323,
                    height: 170,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'De ${rides.startLocation} à ${rides.finalDestination}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Le ${rides.day} à ${rides.goingOffTime}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Logique pour modifier le trajet
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF005573),
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text('Modifier'),
                                ),
                                SizedBox(width: 8.0),
                                ElevatedButton(

                                  onPressed: () {

                                    trajitNotifier.deleteRide(rides.id);
                                    Get.offAll(trajet());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text('Supprimer'),
                                ),
                              ],
                            ),



                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                      child: Text('Aucune donnée  disponible'));
                }
              },
            ),
            Container(
              width: 323,
              height: 400,
              child:  FutureBuilder<List<DemandeRes>>(
                future: DemandeNotifier
                    .getAllDemandsForTheRideCreator(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Erreur de chargement : ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    print(userId);
                    List<DemandeRes> demList =
                    snapshot.data!;
                    return Container(
                      height: 600,
                      width: 360,
                      child: ListView.builder(
                        itemCount: demList.length,
                        itemBuilder: (context, index) {
                          DemandeRes demand =
                          demList[index];
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
                                 Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Demande de la part du',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${demand.user.firstName} ${demand.user.lastName}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Statut : ${demand.status}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                // Logique pour accepter la demande
                                                DemandeNotifier.changeDemandStatus(demand.id, 'Accepted');
                                                Get.offAll(ChatListScreen());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Color(0xFF005573),
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                              child: Text('Accepter'),
                                            ),
                                            SizedBox(width: 8.0),
                                            ElevatedButton(
                                              onPressed: () {
                                                DemandeNotifier.changeDemandStatus(demand.id, 'Refused');
                                                Get.offAll(trajet());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                              child: Text('Refuser'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
            ),

          ],
        ),
      ),
          ],
          ),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        },
        ),
    );
        },
    ),
    );
  }
}
