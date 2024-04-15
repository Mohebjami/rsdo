import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SubProject extends StatefulWidget {
  const SubProject({super.key});

  @override
  State<SubProject> createState() => _SubProjectState();
}

class _SubProjectState extends State<SubProject> {
  final Uri _urlR1 = Uri.parse('https://rsdo.af/about-us/');
  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    double fullScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(45, 47, 98, 1),
          title: const Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Text(
              "GFD Project",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: "BAHNSCHRIFT"),
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: Container(
        height: fullScreenHeight,
        width: fullScreenWidth,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/test.jpg'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 250,
              height: 70,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(45, 47, 98, 0.3),
                borderRadius:BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topRight:  Radius.circular(25),
                ),

              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(45, 47, 98, 0.1),
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                        borderRadius:BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          topRight:  Radius.circular(25),),),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'welcome');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Value Voucher',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "BAHNSCHRIFT",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              height: 70,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(45, 47, 98, 0.3),
                borderRadius:BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topRight:  Radius.circular(25),
                ),

              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(45, 47, 98, 0.1),
                    // shadowColor: const Color.fromRGBO(45, 47, 98, 1),
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius:BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        topRight:  Radius.circular(25),),),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'welcome');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Direct Cash',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "BAHNSCHRIFT",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 270,
              height: 70,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(45, 47, 98, 0.3),
                borderRadius:BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topRight:  Radius.circular(25),
                ),

              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(45, 47, 98, 0.1),
                    // shadowColor: const Color.fromRGBO(45, 47, 98, 1),
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius:BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        topRight:  Radius.circular(25),),),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'welcome');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Commodity Vouchers',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "BAHNSCHRIFT",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              height: 60,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(45, 47, 98, 0.3),
                borderRadius:BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topRight:  Radius.circular(25),
                ),

              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(45, 47, 98, 0.1),
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius:BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        topRight:  Radius.circular(25),),),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'welcome');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'In-Kind/Food',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "BAHNSCHRIFT",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(252,163,19,1),
              ),
              child: MaterialButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'SubProject');
                },
                child: const Text(
                  "Read More",
                  style: TextStyle(
                      color: Color.fromRGBO(45, 47, 98, 1),
                      fontFamily: "BAHNSCHRIFT",
                      fontSize: 15
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
  Future<void> _launchUrlR1() async {
    if (!await launchUrl(_urlR1)) {
      throw Exception('Could not launch $_urlR1');
    }
  }
}
