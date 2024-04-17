import 'package:flutter/material.dart';
import 'package:rsdo/Drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {

  final Uri _urlR1 = Uri.parse('https://rsdo.af/124-22-project-emergency-food-assistance-nfi-and-winterization-support-for-vulnerable-households-through-cash-and-non-cash-distributions-in-the-west-of-afghanistan/');
  final Uri _urlR2 = Uri.parse('https://rsdo.af/federal-ministry-for-economic-cooperation-and-development-bmz/');
  final Uri _urlR3 = Uri.parse('https://rsdo.af/about-us/');

  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: const Color.fromRGBO(45, 47, 98, 1),
            title: const Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                "RSDO App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "BAHNSCHRIFT"),
              ),
            ),
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: IconButton(
                    icon: const ImageIcon(
                      AssetImage("assets/icon/menu.png"),
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                );
              },
            ),
          ),
        ),
        drawer: myDrawer(),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                   Expanded(
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding:  const EdgeInsets.only(left: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "GFD \nProject",
                              style: TextStyle(
                                  color: Color.fromRGBO(45, 47, 98, 1),
                                  fontSize: 20,
                                  fontFamily: "BAHNSCHRIFT"),
                            ),
                            const Text(
                              "Funded by WFP",
                              style: TextStyle(
                                  color: Color.fromRGBO(252, 163, 19, 1),
                                  fontSize: 15,
                                  fontFamily: "BAHNSCHRIFT"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(252,163,19,1),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, 'SubProject');
                                },
                                child: const Text(
                                  "Click Here",
                                  style: TextStyle(
                                      color: Color.fromRGBO(45, 47, 98, 1),
                                      fontFamily: "BAHNSCHRIFT",
                                    fontSize: 15
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 270,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/p1.png"),
                        fit: BoxFit.cover,
                      ),
                      border: BorderDirectional(
                        top: BorderSide(
                            color: Color.fromRGBO(252, 163, 19, 1), width: 2),
                        bottom: BorderSide(
                            color: Color.fromRGBO(252, 163, 19, 1), width: 2),
                        start: BorderSide(
                            color: Color.fromRGBO(252, 163, 19, 1), width: 2),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(27, 30),
                        bottomLeft: Radius.circular(32),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                   Expanded(
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding:  const EdgeInsets.only(left: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "124/22 \nProject",
                              style: TextStyle(
                                  color: Color.fromRGBO(45, 47, 98, 1),
                                  fontSize: 20,
                                  fontFamily: "BAHNSCHRIFT"),
                            ),
                            const Text(
                              "Funded by ADH",
                              style: TextStyle(
                                  color: Color.fromRGBO(252, 163, 19, 1),
                                  fontSize: 15,
                                  fontFamily: "BAHNSCHRIFT"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(252,163,19,1),
                              ),
                              child: MaterialButton(
                                onPressed: _launchUrlR1,
                                child: const Text(
                                  "Read More",
                                  style: TextStyle(
                                      color: Color.fromRGBO(45, 47, 98, 1),
                                      fontFamily: "BAHNSCHRIFT"
                                  ),
                                ),

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 270,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/p2.png"),
                        fit: BoxFit.cover,
                      ),

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(27, 30),
                        bottomLeft: Radius.circular(32),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                   Expanded(
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding:  const EdgeInsets.only(left: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "BMZ \nProject",
                              style: TextStyle(
                                  color: Color.fromRGBO(45, 47, 98, 1),
                                  fontSize: 20,
                                  fontFamily: "BAHNSCHRIFT"),
                            ),
                            const Text(
                              "Funded by BMZ",
                              style: TextStyle(
                                  color: Color.fromRGBO(252, 163, 19, 1),
                                  fontSize: 15,
                                  fontFamily: "BAHNSCHRIFT"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(252,163,19,1),
                              ),
                              child: MaterialButton(
                                onPressed: _launchUrlR2,
                                child: const Text(
                                  "Read More",
                                  style: TextStyle(
                                      color: Color.fromRGBO(45, 47, 98, 1),
                                      fontFamily: "BAHNSCHRIFT"
                                  ),
                                ),

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 270,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/p3.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(27, 30),
                        bottomLeft: Radius.circular(32),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        )
    );
  }

  Future<void> _launchUrlR1() async {
    if (!await launchUrl(_urlR1)) {
      throw Exception('Could not launch $_urlR1');
    }
  }

  Future<void> _launchUrlR2() async {
    if (!await launchUrl(_urlR2)) {
      throw Exception('Could not launch $_urlR2');
    }
  }

  Future<void> _launchUrlR3() async {
    if (!await launchUrl(_urlR3)) {
      throw Exception('Could not launch $_urlR3');
    }
  }
}
