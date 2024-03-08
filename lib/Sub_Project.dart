import 'package:flutter/material.dart';

class SubProject extends StatefulWidget {
  const SubProject({super.key});

  @override
  State<SubProject> createState() => _SubProjectState();
}

class _SubProjectState extends State<SubProject> {
  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    double fullScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: fullScreenHeight,
        width: fullScreenWidth,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/project.jpg'), fit: BoxFit.cover)),
        child: Center(
          child: SizedBox(
            height: fullScreenHeight - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(50, 41, 36, 0.4),
                        blurRadius: 15,
                        spreadRadius: 10,
                        offset: Offset(1, 1), // moves the shadow up
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.white30)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'welcome');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Value Voucher',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: "LilitaOne"),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(50, 41, 36, 0.4),
                        blurRadius: 15,
                        spreadRadius: 10,
                        offset: Offset(1, 1), // moves the shadow up
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.white30)),
                    ),
                    onPressed: () {
                      print('Button pressed');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Direct Cash',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: "LilitaOne"),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(50, 41, 36, 0.4),
                        blurRadius: 15,
                        spreadRadius: 10,
                        offset: Offset(1, 1), // moves the shadow up
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.white30)),
                    ),
                    onPressed: () {
                      print('Button pressed');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Food Distribution',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: "LilitaOne"),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(50, 41, 36, 0.4),
                        blurRadius: 15,
                        spreadRadius: 10,
                        offset: Offset(1, 1), // moves the shadow up
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.white30)),
                    ),
                    onPressed: () {
                      print('Button pressed');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Commodity Voucher',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: "LilitaOne"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
