import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_and_go/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> with SingleTickerProviderStateMixin{
  late bool _hasToken;
  @override
  void initState() {
    super.initState();
    _checkToken(); // Appeler la méthode pour vérifier si un token existe
  }

  // Méthode pour vérifier si un token existe dans les SharedPreferences
  void _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Récupérer le token depuis les préférences partagées

    setState(() {
      _hasToken = token != null; // Définir _hasToken en fonction de la présence du token
    });

    _navigateToCorrectPage(); // Appeler la méthode pour naviguer vers la bonne page
  }

  // Méthode pour naviguer vers la page login ou home en fonction de la présence du token
  void _navigateToCorrectPage() {
    // Utiliser Navigator.pushReplacement pour naviguer sans retour arrière
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => _hasToken ? home() : loginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    // Réactiver le mode d'interface utilisateur système avant de quitter la page
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width:double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF232D4B),Color(0xFF005573)],
          begin:Alignment.bottomCenter,
          end: Alignment.topCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo2.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain, // Choose a fit option
            ),
            SizedBox(height: 20),
            Text(
             '''  Find Your Partner
     Destination With Us''',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
