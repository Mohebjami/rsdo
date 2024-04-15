import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final Uri _url = Uri.parse('https://rsdo.af/about-us/');
  final Uri _urlR1 = Uri.parse('https://rsdo.af/about-us/');
  final Uri _urlR2 = Uri.parse('https://rsdo.af/about-us/');
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
            // leading: Padding(
            //   padding: const EdgeInsets.only(top: 20.0),
            //   child: IconButton(
            //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            //     onPressed: () => Navigator.of(context).pop(),
            //   ),
            // ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
                                  "Open",
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
                height: 20,
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
                height: 20,
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
                                onPressed: _launchUrlR3,
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
              const SizedBox(
                height: 40,
              ),
              Container(
                width: fullScreenWidth,
                height: 50,
                color: const Color.fromRGBO(66,66,68, 0.1),
                child: Center(
                    child: GestureDetector(
                      onTap: _launchUrl,
                      child: const Text("About RSDO",
                        style: TextStyle(
                            color: Color.fromRGBO(45, 47, 98, 1),
                            fontSize: 15, fontFamily: "BAHNSCHRIFT",
                            fontWeight: FontWeight.bold,
                         decoration: TextDecoration.underline,

                      ),),
                    ),
                ),
              )
            ],
          ),
        )
    );
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchUrlR1() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_urlR1');
    }
  }

  Future<void> _launchUrlR2() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_urlR2');
    }
  }

  Future<void> _launchUrlR3() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_urlR3');
    }
  }


}
