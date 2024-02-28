import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rsdo/FetchData.dart';

class Sarvear extends StatefulWidget {
  const Sarvear({super.key});

  @override
  State<Sarvear> createState() => _SarvearState();
}

class _SarvearState extends State<Sarvear> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late var test_data;
  int press = 0;
  bool hasInternet = false;
  bool isCorrect = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Distributor Login", style: TextStyle(fontFamily: "LilitaOne" ,fontWeight: FontWeight.bold , fontSize: 22,color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/logo.png",
                  width: 250,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.4,
              right: 35,
              left: 35,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 330,
                  child: TextField(
                    controller: email,
                    style: const TextStyle(
                        color: Color.fromRGBO(44, 62, 82, 1)
                    ),
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(234, 235, 237, 1),
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 330,
                  child: TextField(
                    controller: password,
                    style: const TextStyle(
                        color: Color.fromRGBO(44, 62, 82, 1)
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: const Color.fromRGBO(234, 235, 237, 1),
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: Colors.grey,
                                ),
                              );
                            });
                      });
                      hasInternet = await InternetConnectionChecker().hasConnection;
                      Navigator.of(context).pop();
                      if (!hasInternet) {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'No Internet',
                                  style: TextStyle(color: Colors.red),
                                ),
                                icon: const Image(
                                  image: AssetImage("assets/no-wifi.png"),
                                  width: 35,
                                  height: 35,
                                ),
                                iconColor: Colors.red,
                                content: const Text(
                                    '     Please connect to internet',
                                    style: TextStyle(color: Colors.red)),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Done'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        Map<String, dynamic> data;
                        int i = 0;
                        press++;
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    backgroundColor: Colors.grey,
                                  ),
                                );
                              });
                        });
                        final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Surveyor').get();
                        Navigator.of(context).pop();
                        while (i < snapshot.docs.length) {
                          data = snapshot.docs[i].data() as Map<String, dynamic>;
                          if (data['Email'] == email.text && data['Password'] == password.text) {
                            setState(() {
                              isCorrect = true;
                              test_data = data['Surveyor'];
                            });
                            Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                builder: (context) => FetchData(data: test_data),
                              ),
                            );
                          }
                          i++;
                        }
                        email.clear();
                        password.clear();

                      }
                      if (isCorrect == false) {
                        setState(() {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                            Text('Your username or password wrong'),
                            backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                            showCloseIcon: true,
                            duration: Duration(seconds: 2),
                          ));
                        });
                      }
                      if (press > 3) {
                        press = 0;
                        setState(() {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'If you forget you Email or password connect to admin'),
                            backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                            showCloseIcon: true,
                            duration: Duration(seconds: 2),
                          ));
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromRGBO(126, 145, 162, 1)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ),
                    child: const Text("Login" , style: TextStyle(fontFamily: "LilitaOne" ,fontWeight: FontWeight.bold , fontSize: 22 ,color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
