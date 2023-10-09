import 'package:flutter/material.dart';
import 'package:rsdo/AdminLogin.dart';
import 'package:rsdo/Sarvear.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/welcome.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            bottom: const PreferredSize(
              preferredSize: Size(5, 5),
              child: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    child: Image(image: AssetImage("assets/database.png"), width: 35,)
                    
                  ),
                  Tab(
                      child: Image(image: AssetImage("assets/admin.png"), width: 30, color: Color.fromRGBO(255, 255, 255, 0.9),)
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: TabBarView(
            children: [
              AdminLogin(),
              Sarvear(),
            ]

          ),
        ),
      ),
    );
  }
}
