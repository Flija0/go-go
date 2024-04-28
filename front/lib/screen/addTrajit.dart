import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:go_and_go/models/request/trajiReq_model.dart';
import 'package:go_and_go/screen/trajet.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../location_service.dart';
import 'home.dart';
import 'Cars.dart';
import '../controllers/Trajit_provider.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class addtrajit extends StatefulWidget {
  const addtrajit({Key? key}) : super(key: key);

  @override
  State<addtrajit> createState() => _addtrajitState();
}

class _addtrajitState extends State<addtrajit> {
  Completer<GoogleMapController> _controller = Completer();
  String day ='';



  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController goingOffTime = TextEditingController();
  final TextEditingController numberOfSeats = TextEditingController();
  final TextEditingController femaleOnly = TextEditingController();
  final TextEditingController consumption = TextEditingController();


  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    goingOffTime.dispose();
    numberOfSeats.dispose();
    femaleOnly.dispose();
    consumption.dispose();

    super.dispose();
  }

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
        )
            .toList(),
      ),
    );
  }


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.8485046, 10.2717583),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(36.8485046, 10.2717583),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override



  late int userId;
  void initState() {
    super.initState();
    _loadUserInfo();
    _setMarker(LatLng(36.8485046, 10.2691834));
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
  int _counter = 1;

  void _incrementCounter() {
    if (_counter < 4) {
      setState(() {
        _counter++;
      });
    }
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }

  TextEditingController _timeController = TextEditingController();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  bool isTodaySelected = false;
  bool isTomorrowSelected = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TrajitNotifier>(
      create: (_) => TrajitNotifier(),
      child: Consumer<TrajitNotifier>(
        builder: (context, trajitNotifier, child) {
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
                    SizedBox(height: 23),
                    Form(
                      key: trajitNotifier.TrajitFormKey,
                      child: Column(
                        children: [
                          Container(
                            width: 311,
                            child: TextFormField(
                              controller:_originController,
                              style: TextStyle(color: Colors.black),
                              //obscureText: loginNotifier.obscureText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Le champ Password ne doit pas être vide';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Votre point de depart",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical:
                                    16), // Ajuster la taille du champ de saisie
                                filled: true,
                                fillColor: Color(0xFFFCFFFD),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  // Définir le style de la bordure quand le champ n'est pas en focus
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: BorderSide(
                                      color: Color(0xFFFCFFFD), width: 2),
                                ),
                                prefixIcon:
                                Icon(Icons.location_on, color: Colors.red),

                              ),

                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 311,
                            child: TextFormField(
                              controller: _destinationController ,
                              onChanged:(value){
                                print(value);
                              },
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Le champ email ne doit pas être vide';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Votre point d'arrivage",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical:
                                    16), // Ajuster la taille du champ de saisie
                                filled: true,
                                fillColor: Color(0xFFFCFFFD),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  // Définir le style de la bordure quand le champ n'est pas en focus
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: BorderSide(
                                      color: Color(0xFFFCFFFD), width: 2),
                                ),
                                prefixIcon:
                                Icon(Icons.location_on, color: Colors.blue),
                                suffixIcon:
                                IconButton( onPressed: () async {
                                  var directions = await LocationService().getDirections(
                                    _originController.text.toString(),
                                    _destinationController.text.toString(),
                                  );
                                  _goToPlace(
                                    directions['start_location']['lat'],
                                    directions['start_location']['lng'],
                                    directions['bounds_ne'],
                                    directions['bounds_sw'],
                                  );

                                  _setPolyline(directions['polyline_decoded']);
                                }, icon: Icon(Icons.search, color: Colors.red),),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          Container(
                            height: 350,
                            child: GoogleMap(
                              mapType: MapType.normal,
                              markers: _markers,
                              polygons: _polygons,
                              polylines: _polylines,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              onTap: (point) {
                                setState(() {
                                  polygonLatLngs.add(point);
                                  _setPolygon();
                                });
                              },
                            ),


                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 355,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_month,
                                        color: Color(0xFF00AA9B)),
                                    Text(
                                      'Quand ?',
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Color(
                                            0xFF00AA9B), // Couleur par défaut du texte
                                      ),
                                    ),
                                    // Ajout d'un SizedBox pour l'espacement

                                    // Premier Container avec TextButton pour "Aujourd'hui"
                                    Container(
                                      padding: EdgeInsets.all(1),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: isTodaySelected
                                            ? Color(0xFF00AA9B)
                                            : Color(
                                            0x33000000), // Couleur de fond du bouton "Modifier"
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            day ='Today';
                                            isTomorrowSelected = false;
                                            isTodaySelected =
                                            !isTodaySelected; // Toggle state
                                          });
                                        },
                                        child: Text(
                                          'Aujourd\'hui',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Ajout d'un SizedBox pour l'espacement

                                    // Deuxième Container avec TextButton pour "Demain"
                                    Container(
                                      padding: EdgeInsets.all(1),
                                      width: 136,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: isTomorrowSelected
                                            ? Color(0xFF00AA9B)
                                            : Color(
                                            0x33000000), // Couleur de fond du bouton "Modifier"
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                             day ='Tomorrow';
                                            isTomorrowSelected =
                                            !isTomorrowSelected;
                                            isTodaySelected =
                                            false; // Toggle state
                                          });
                                        },
                                        child: Text(
                                          'Demain',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.access_time_sharp,
                                            color: Color(0xFF00AA9B)),
                                        Text(
                                          'A quelle heure ? ',
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500,
                                            color: Color(
                                                0xFF00AA9B), // Couleur par défaut du texte
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(1),
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            color: Color(
                                                0xFF00AA9B), // Couleur de fond du bouton "Modifier"
                                          ),
                                          child: Expanded(
                                            child: TextFormField(
                                              controller: _timeController,
                                              readOnly: true,
                                              onTap: () {
                                                _selectTime(context);
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Select Time',
                                                border: InputBorder.none,
                                                suffixIcon:
                                                Icon(Icons.access_time),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Icon(Icons.group_add_rounded,
                                            color: Color(0xFF00AA9B)),
                                        Text(
                                          'Places disponibles ?',
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500,
                                            color: Color(
                                                0xFF00AA9B), // Couleur par défaut du texte
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[

                                              // Add spacing between elements
                                              IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: _decrementCounter,
                                              ),

                                              Text(
                                                '$_counter',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: _incrementCounter,
                                              ),
                                            ],
                                          ),
                                        ),



                                      ],

                                    ),
                                    SizedBox(height: 10),
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
                                              Get.offAll(home());
                                            },
                                            child: Center(
                                              child: Text(
                                                'Annuler',
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
                                        SizedBox(width:50, height: 16), // Espacement entre les boutons
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
                                              if (trajitNotifier.validateAndSave()) {
                                                TrajitModelReq model = TrajitModelReq(
                                                  startLocation:_originController.text,
                                                  finalDestination: _destinationController.text,
                                                  femaleOnly: false,
                                                  consumption: 20,
                                                  goingOffTime:_timeController.text ,
                                                  day: day,
                                                  numberOfSeats: _counter,
                                                );
                                                trajitNotifier.addRide(userId, model );
                                                Get.offAll(trajet());
                                                debugPrint('Car Saved $TrajitModelReq');

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
                                              print(_originController.text);
                                              print(_destinationController.text);
                                              print(_timeController.text);
                                              print(day);
                                              print(_counter);
                                            },
                                            child: Center(
                                              child: Text(
                                                'Publier',
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
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          /*TextFormField(
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
                              prefixIcon: Icon(Icons.code, color: Colors.grey),
                            ),
                          ),*/

                          /*TextFormField(
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
                          ),*/

                          /*TextFormField(
                            controller: photo,
                            style: TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Le champ image ne doit pas être vide';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Ajouter une photo de la voiture",
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
                          SizedBox(height: 100),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.offAll(regseterone());
                                },
                                child: Text('Précédent'),
                              ),
                              SizedBox(width: 16),
                              ElevatedButton(
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
                                },
                                child: Text('Suivant'),
                              ),
                            ],
                          ),*/
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
  Future<void> _goToPlace(
       //Map<String, dynamic> place,
      double lat,
      double lng,
      Map<String, dynamic> boundsNe,
      Map<String, dynamic> boundsSw,
      ) async {
     //final double lat = place['geometry']['location']['lat'];
    //final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
    _setMarker(LatLng(lat, lng));
  }
}

