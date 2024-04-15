import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);
  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("Projects");
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: const Color.fromRGBO(45, 47, 98, 1),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage("assets/logo.png"),
                width: 300,
              ),
              const SizedBox(
                height: 180,
              ),
              const Text("Welcome to", style: TextStyle(color: Colors.white,fontSize: 30),),
              const Text("RSDO App", style: TextStyle(color: Colors.white,fontSize: 40),),
               Padding(
                 padding: const EdgeInsets.only(top: 100.0),
                 child: LoadingAnimationWidget.newtonCradle(
                   color: Colors.white,
                   size: 100,
                 ),
               ),

              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  "Develop by IT & Visibility Department \n(Moheb Jami)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
