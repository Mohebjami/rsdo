import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    double fullScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(44, 62, 82, 1),
      body: SizedBox(
        height: fullScreenHeight,
        width: fullScreenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.blue)
                      )
                  )
              ),
              onPressed: () { Navigator.pushNamed(context, 'welcome'); },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Value Voucher',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.blue)
                      )
                  )
              ),
              onPressed: () { print('Button pressed'); },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Cash',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.blue)
                      )
                  )
              ),
              onPressed: () { print('Button pressed'); },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Food',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.blue)
                      )
                  )
              ),
              onPressed: () { print('Button pressed'); },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Button',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),



            Container(
              color: Colors.red,
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your button logic here
                        },
                        style: ElevatedButton.styleFrom(
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child: Text('My Button'),
                      )


                    ),
                  ),
                ],
              ),
            ),





            SizedBox(
              height: 30,
            ),




            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800],
                  onPrimary: Colors.grey[300],
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: Container(
                  width: 120,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Button',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Consolas',
                    ),
                  ),
                ),
              ),
            ),








          ],
        ),
      ),
    );
  }
}
