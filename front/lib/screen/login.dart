import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_and_go/controllers/login_provider.dart';
import 'package:go_and_go/models/request/auth/login_model.dart';
import 'package:provider/provider.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
      return Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          child: Container(
            height: 800,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF232D4B), Color(0xFF005573)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Form(
              key: loginNotifier.loginFormKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 80),
                      Container(
                        width: 343,
                        height: 600,
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.10000000149011612),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20),
                            Image.asset(
                              'assets/logo/logo1.png',
                              width: 114,
                              height: 148,
                              fit: BoxFit.contain, // Choose a fit option
                            ),
                            SizedBox(height: 30),
                            Container(
                              width: 311,
                              child: TextFormField(
                                controller: _email,
                                style: TextStyle(color: Colors.black),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Le champ email ne doit pas être vide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Votre Email/id",
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
                                      Icon(Icons.person, color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: 311,
                              child: TextFormField(
                                controller: _password,
                                style: TextStyle(color: Colors.black),
                                obscureText: loginNotifier.obscureText,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Le champ Password ne doit pas être vide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Votre Mot de Passe",
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
                                      Icon(Icons.lock, color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            Column(
                              children: [
                                Container(
                                  child: Container(
                                    width: 311,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF005573),
                                          Color(0xFF00AA9B)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .transparent, // Rendre la couleur de fond transparente
                                        onPrimary:
                                            Colors.white, // Couleur du texte
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (loginNotifier.validateAndSave()) {
                                          LoginModelReq model = LoginModelReq(
                                            email: _email.text,
                                            mdp: _password.text,

                                          );
                                          loginNotifier.userLogin(model);
                                        } else {
                                          Get.snackbar("Lgin Failed", "please tray ");
                                        }

                                        // Actions à exécuter lorsque le bouton est pressé
                                      },
                                      child: Center(
                                        child: Text(
                                          'Se connecter',
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
                            SizedBox(height: 20),
                            Column(
                              children: [
                                Container(
                                  width: 268.76,
                                  height: 44,
                                  child: Text(
                                    "Si vous rencontrez des difficultés, veuillez contacter",
                                    style: const TextStyle(
                                      fontFamily: "Gilroy",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffFFFFFF),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 300,
                                  child: Image.asset(
                                    'assets/logo/logoinetum.png',
                                    width: 200,
                                    height: 300,
                                    fit: BoxFit.contain, // Choose a fit option
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
