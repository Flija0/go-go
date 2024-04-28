import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_and_go/screen/Regster2.dart';
import 'package:go_and_go/screen/login.dart';

import 'Regster1.dart';
import 'home.dart';


class startScreen extends StatefulWidget {
  const startScreen({Key? key}) : super(key: key);

  @override
  State<startScreen> createState() => _startScreenState();
}

class _startScreenState extends State<startScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF232D4B),Color(0xFF005573)],
              begin:Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Column(
          children: [
            SizedBox(height: 66),
              Column(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/img/Startimage1.png',
                      width: 371,
                      height: 237,
                      fit: BoxFit.contain, // Choose a fit option
                    ),
                  ),
                ],
              ),
            SizedBox(height: 72),
            Column(
              children: [
                Container(
                  width: 319,
                  height: 180,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // Couleur par défaut du texte
                      ),
                      children: [
                        TextSpan(
                          text: "Go&Go",
                          style: TextStyle(
                            color: Color(0xFFF04641), // Couleur rouge pour "Go"
                          ),
                        ),
                        TextSpan(
                          text: " by Inetum est une application de covoiturage interne qui simplifie et encourage le partage de trajets entre collègues, tout en optimisant la réduction des émissions de carbone.",
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 98),
            Column(
              children: [
                Container(
                  child: Container(
                    width: 311,
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
                      onPressed: () {Get.offAll(regseterone());
                        // Actions à exécuter lorsque le bouton est pressé
                      },

                      child: Center(
                        child: Text(
                          'Commencer',
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

                ),
              ],
            ),
          ],
        ),

      ),

    );
  }
}