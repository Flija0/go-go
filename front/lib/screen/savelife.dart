import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_and_go/NavBar/nav_bar.dart';
import 'package:go_and_go/NavBar/nav_bar_backup.dart';
import 'package:provider/provider.dart';

import '../controllers/Cars_provider.dart';
import '../controllers/consumtion_provider.dart';
import '../models/consumepation.dart';
import 'Regster2.dart';
import 'addTrajit.dart';
class savelife extends StatefulWidget {
  const savelife({Key? key}) : super(key: key);

  @override
  State<savelife> createState() => _savelifeState();
}

class _savelifeState extends State<savelife> {
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConsumptionProvider>(
      create: (_) => ConsumptionProvider(),
      child: Consumer<ConsumptionProvider>(
        builder: (context, ConsumptionProvider, child) {
    return ChangeNotifierProvider<CarNotifier>(
      create: (_) => CarNotifier(),
      child: Consumer<CarNotifier>(
        builder: (context, carNotifier, child) {
    return  Scaffold(
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
                )),

            FutureBuilder(
              future: Future.wait([
                ConsumptionProvider.getTopThreeSavedConsumers(),
                ConsumptionProvider.getTotalConsumptionSaved(),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<ConsumptionModel> topThreeConsumers = snapshot.data![0] as List<ConsumptionModel>;
                  int totalConsumptionSaved = snapshot.data![1] as int;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Column(
                         children:[Column(
                           children: [
                             Text(
                              'Top 3 ',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00AA9B),
                              ),
                        ),
                             Text(
                               'Consommateurs économisés',
                               style: TextStyle(
                                 fontSize: 24.0,
                                 fontWeight: FontWeight.bold,
                                 color: Color(0xFF00AA9B),
                               ),
                             ),
                           ],
                         ),],
                      ),
                      Container(
                        width: 400,
                        height: 390,
                        child: ListView.builder(
                          itemCount: topThreeConsumers.length,
                          itemBuilder: (context, index) {
                            ConsumptionModel consumer = topThreeConsumers[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 6.0,
                              ),
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(0xFF005573),
                                        child: Text(
                                          '${consumer.firstName[0]}${consumer.lastName[0]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${consumer.firstName} ${consumer.lastName}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 2.0),
                                            Text(
                                              'Consommation prévue: ${consumer.consumptionExpected}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey[600],
                                              ),
                                            ),
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
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Consommation totale économisée :',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(
                                        0xFF00AA9B),
                                  ),
                                ),
                                Text(
                                  '$totalConsumptionSaved',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(
                                        0xFF26DA0A),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
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
      bottomNavigationBar: NavBarBackup(
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
  }
}
