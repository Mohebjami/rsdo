import 'package:flutter/material.dart';
import 'package:rsdo/AdminLogin.dart';
import 'package:rsdo/SurveyorLogin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(44, 62, 82, 1)),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            bottom: const PreferredSize(
              preferredSize: Size(5, 5),
              child: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                      child: Image(
                    image: AssetImage("assets/database.png"),
                    width: 35,
                  )),
                  Tab(
                      child: Image(
                    image: AssetImage("assets/user.png"),
                    width: 30,
                  )),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: const TabBarView(children: [
            AdminLogin(),
            Sarvear(),
          ]),
        ),
      ),
    );
  }
}
