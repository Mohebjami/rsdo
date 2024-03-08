import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsdo/Add_Admin.dart';
import 'package:rsdo/Add_Surveyor.dart';
import 'package:rsdo/Controller.dart';
import 'package:rsdo/FetchDataAdmin.dart';
import 'package:rsdo/FetchPaidData.dart';
import 'package:rsdo/Projects.dart';
import 'package:rsdo/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rsdo/Sub_Project.dart';
import 'package:rsdo/WelcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAqSsOSsi976UtMVMKwie_z01n19rC25y4",
            authDomain: "rsdo-database.firebaseapp.com",
            projectId: "rsdo-database",
            storageBucket: "rsdo-database.appspot.com",
            messagingSenderId: "1046325775468",
            appId: "1:1046325775468:web:cbc4595afcf1597a75dc49",
            measurementId: "G-NVTQD2EHKQ"
        ));
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'start',
    routes: {
      'start': (context) => const SplachScreen(),
      'Projects': (context) => const Projects(),
      'SubProject': (context) => const SubProject(),
      'welcome': (context) => const LoginPage(),
      'show': (context) =>  const FetchDataAdmin(),
      'FetchPaidData': (context) =>  const FetchPadiData(),
      'Surveyor': (context) => const Add_Sarver(),
      'admin': (context) => const Add_Admin(),
    },
  ));
}
