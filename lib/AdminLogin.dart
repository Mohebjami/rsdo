import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hasInternet = false;
  int press = 0;
  late bool _isLoding;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 35, top: 100),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontFamily: "RobotoSlab"),
              ),
              Text(
                ' Admin Page',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "RobotoSlab"),
              ),
            ],
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
                TextField(
                  controller: email,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    fillColor: const Color(0xff4c505b),
                    filled: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: password,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: const Color(0xff4c505b),
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      " Login",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          fontSize: 27,
                          fontFamily: "RobotoSlab",
                          fontWeight: FontWeight.w700),
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async{
                          setState(() {
                            showDialog(context: context, builder: (context){
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                          });
                            hasInternet = await InternetConnectionChecker().hasConnection;
                          Navigator.of(context).pop();
                            if(!hasInternet){
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('No Internet' , style: TextStyle(color: Colors.red),),
                                      icon: const Icon(Icons.error),
                                      iconColor: Colors.red,
                                      content: const Text('Please connect to internet'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Done'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );
                            }
                            else{
                              var data;
                              int i = 0;
                              press++;
                              setState(() {
                                showDialog(context: context, builder: (context){
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                              });
                              final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Accounts').get();
                              Navigator.of(context).pop();
                              while (i < snapshot.docs.length) {
                                data = snapshot.docs[i].data() as Map<String, dynamic>;
                                if (data['Email'] == email.text && data['Password'] == password.text) {
                                  Navigator.pushNamed(context, "export");
                                  break;
                                }
                                else if (press > 3) {
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
                                } else {
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Wrong username or password'),
                                      backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                                      showCloseIcon: true,
                                      duration: Duration(seconds: 2),
                                    ));
                                  });
                                }
                                i++;
                              }
                            }
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          // getData();
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              fontFamily: "RobotoSlab"),
                        ))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
