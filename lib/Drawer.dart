import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:url_launcher/url_launcher.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({super.key});

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  final Uri _urlR1 = Uri.parse('https://rsdo.af/vision/');
  final Uri _urlR2 = Uri.parse('https://rsdo.af/mission/');
  final Uri _urlR3 = Uri.parse('https://rsdo.af/ongoing-projects/');
  final Uri _urlR4 = Uri.parse('https://rsdo.af/completed-projects/');
  final Uri _urlR5 = Uri.parse('https://rsdo.af/about-us/');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Drawer(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.shade200.withOpacity(0.5)),
              child: SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          const Color.fromRGBO(45, 47, 98, 1).withOpacity(0.3)),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      const Image(
                        image: AssetImage(
                          "assets/rsdo.png",
                        ),
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: ListTile(
                          title: const Text(
                            'VISION',
                            style: TextStyle(
                                fontFamily: "Neirizi", color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _launchUrl1();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: ListTile(
                          title: const Text(
                            'MISSION',
                            style: TextStyle(
                                fontFamily: "Neirizi", color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _launchUrl2();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: ListTile(
                          title: const Text(
                            'ONGOING PROJECTS',
                            style: TextStyle(
                                fontFamily: "Neirizi", color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _launchUrl3();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: ListTile(
                          title: const Text(
                            'COMPLETED PROJECTS',
                            style: TextStyle(
                                fontFamily: "Neirizi", color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _launchUrl4();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: ListTile(
                          title: const Text(
                            'ABOUT RSDO',
                            style: TextStyle(
                                fontFamily: "Neirizi", color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _launchUrl5();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl1() async {
    if (!await launchUrl(_urlR1)) {
      throw Exception('Could not launch $_urlR1');
    }
  }

  Future<void> _launchUrl2() async {
    if (!await launchUrl(_urlR2)) {
      throw Exception('Could not launch $_urlR2');
    }
  }

  Future<void> _launchUrl3() async {
    if (!await launchUrl(_urlR3)) {
      throw Exception('Could not launch $_urlR3');
    }
  }

  Future<void> _launchUrl4() async {
    if (!await launchUrl(_urlR4)) {
      throw Exception('Could not launch $_urlR4');
    }
  }

  Future<void> _launchUrl5() async {
    if (!await launchUrl(_urlR5)) {
      throw Exception('Could not launch $_urlR5');
    }
  }
}
