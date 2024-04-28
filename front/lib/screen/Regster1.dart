import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Regster2.dart';
import 'home.dart';
class regseterone extends StatefulWidget {
  const regseterone({Key? key}) : super(key: key);

  @override
  State<regseterone> createState() => _regseteroneState();
}

List<String> optionsV =['Oui','Non'];

class _regseteroneState extends State<regseterone> {
  String currentOptions=optionsV[1];
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
            SizedBox(height: 30),
            Column(
              children: [
                Container(
                  child: Image.asset(
                    'assets/img/Carimage1.png',
                    width: 400,
                    height: 300,
                    fit: BoxFit.contain, // Choose a fit option
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Column(
              children: [
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // Couleur par défaut du texte
                      ),
                      children: [
                        TextSpan(
                          text: "Avez-vous une ",
                        ),
                        TextSpan(
                          text: "Voiture ",
                          style: TextStyle(
                            color: Color(0xFFF04641), // Couleur rouge pour "Go"
                          ),
                        ),
                        TextSpan(
                          text: "?",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
          Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      width: 150, // Définir la largeur du conteneur du Radio
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text("Oui",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            leading: Container(
                              // Définir la hauteur du conteneur du Radio
                              child: Radio(
                                value: optionsV[0],
                                groupValue: currentOptions,
                                onChanged: (value) {
                                  setState(() {
                                    currentOptions = value.toString();
                                  });
                                },
                                materialTapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Réduit la taille du Radio
                              ),
                            ),

                          ),
                          ListTile(

                            title: const Text(
                              "Non",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            leading: Container(

                              child: Radio(
                                value: optionsV[1],
                                groupValue: currentOptions,
                                onChanged: (value) {
                                  setState(() {
                                    currentOptions = value.toString();
                                  });
                                },
                                materialTapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Réduit la taille du Radio
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

            SizedBox(height: 150),
        Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      if (currentOptions == optionsV[0]) {
                        // If "Oui" is selected
                        Get.offAll(resgstertwo());
                      } else {
                        // If "Non" is selected
                        Get.offAll(home());
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
                SizedBox(height: 16), // Espacement entre les boutons

              ],
            ),
          ],
        ),
      ),
    );
  }
}