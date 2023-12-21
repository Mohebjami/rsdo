import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);
  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed("HomePage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/logo.png"),
              width: 300,
            ),
            SizedBox(
              height: 50,
            ),
            SpinKitFadingCircle(
              color: Color.fromRGBO(47, 47, 94, 1),
              size: 50.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 90,
              ),
              child: Text(
                "Version 1.0",
                style: TextStyle(
                    color: Color.fromRGBO(47, 47, 94, 1), fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                "Develop by Moheb Jami",
                style: TextStyle(
                    color: Color.fromRGBO(47, 47, 94, 1), fontSize: 15),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
