import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_and_go/screen/Chat/chat_list_screen.dart';
import 'package:go_and_go/screen/addTrajit.dart';
import 'package:go_and_go/screen/test.dart';
import 'package:go_and_go/screen/trajet.dart';
import 'package:go_and_go/screen/Regster1.dart';
import 'package:go_and_go/screen/Regster2.dart';
import 'package:go_and_go/screen/Regster3.dart';
import 'package:go_and_go/screen/Chat/chat1.dart';
import 'package:go_and_go/screen/groupe.dart';
import 'package:go_and_go/screen/home.dart';
import 'package:go_and_go/screen/login.dart';
import 'package:go_and_go/screen/parametres.dart';
import 'package:go_and_go/screen/savelife.dart';
import 'package:go_and_go/screen/splash_screen.dart';
import 'package:go_and_go/screen/startScreen.dart';
import 'package:go_and_go/testmaps.dart';
import 'package:provider/provider.dart';
import 'controllers/Cars_provider.dart';
import 'controllers/Trajit_provider.dart';
import 'controllers/chat_provider.dart';
import 'controllers/login_provider.dart';



 Widget defaultHome =  splashScreen();

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();

 // final SharedPreferences prefs = await SharedPreferences.getInstance();

  //final entrypoint = prefs.getBool('entrypoint') ?? false;
 // final loggedIn = prefs.getBool('loggedIn') ?? false;
  //    if (entrypoint && !loggedIn) {
    //  defaultHome = const loginScreen();
     // } else if (entrypoint && loggedIn) {
     // defaultHome = const home();
    //}
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginNotifier()),
      ChangeNotifierProvider(create: (context) => CarNotifier()),
      ChangeNotifierProvider(create: (context) => TrajitNotifier()),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
      ChangeNotifierProvider(create: (context) => TrajitNotifier()),
    ],
    child: const MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Inetum Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: defaultHome,
      routes: {
        '/home': (context) => home(),
        '/addtrajet': (context) => trajet(),
        '/groupe': (context) => groupe(),
        '/parametres': (context) => parametres(),
        '/savelive': (context) => savelife(),
        '/chat1': (context) => ChatListScreen(),
        '/login': (context) => loginScreen(),
        '/start': (context) => startScreen(),
      },
  
    );
  }
}

