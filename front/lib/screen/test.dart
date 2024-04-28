/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/Trajit_provider.dart';
import '../controllers/demande_provider.dart';
import '../models/response/DemandeRes.dart';
import '../models/response/trajitRes_Model.dart';

class RidePage extends StatefulWidget {
  @override
  _RidePageState createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  late int userId;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    // Remplacez cette logique par la récupération réelle de l'ID de l'utilisateur
    userId = 1;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrajitNotifier()),
        ChangeNotifierProvider(create: (_) => DemandeNotifier()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mes Trajets'),
          backgroundColor: Color(0xFF005573),
        ),
        body: Consumer2<TrajitNotifier, DemandeNotifier>(
          builder: (context, trajitProvider, demandeProvider, child) {
            return FutureBuilder(
              future: Future.wait([
                trajitProvider.getRideById(1),
                demandeProvider.getAllDemandsForTheRideCreator(1),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur : ${snapshot.error}'));
                } else {
                  List<TrajitModelRes> rides = snapshot.data![0] as List<TrajitModelRes>;
                  List<DemandeRes> demands = snapshot.data![1] as List<DemandeRes>;

                  return ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Mes Trajets : ',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF005573),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: rides.length,
                        itemBuilder: (context, index) {
                          TrajitModelRes ride = rides[index];
                          return TrajitCard(ride: ride);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Mes Demandes',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF005573),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: demands.length,
                        itemBuilder: (context, index) {
                          DemandeRes demand = demands[index];
                          return DemandeCard(demand: demand);
                        },
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class TrajitCard extends StatelessWidget {
  final TrajitModelRes ride;

  TrajitCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                'De ${ride.startLocation} à ${ride.finalDestination}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Le ${ride.day} à ${ride.goingOffTime}',
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
                      // Logique pour supprimer le trajet
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
  }
}

class DemandeCard extends StatelessWidget {
  final DemandeRes demand;

  DemandeCard({required this.demand});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                'Demande pour le trajet ${demand.ride.creator.firstName}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
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
                      // Logique pour refuser la demande
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
    );
  }
}*/