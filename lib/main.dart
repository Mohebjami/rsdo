import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsdo/Add_Admin.dart';
import 'package:rsdo/Add_Surveyor.dart';
import 'package:rsdo/Controller.dart';
import 'package:rsdo/FetchDataAdmin.dart';
import 'package:rsdo/FetchPaidData.dart';
import 'package:rsdo/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rsdo/WelcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  ));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'start',
    routes: {
      'start': (context) => const SplachScreen(),
      'welcome': (context) => const WelcomePage(),
      'export': (context) => const Export(),
      'show': (context) =>  FetchDataAdmin(),
      'FetchPaidData': (context) =>  FetchPadiData(),
      'Surveyor': (context) => const Add_Sarver(),
      'admin': (context) => const Add_Admin(),
    },
  ));
}
