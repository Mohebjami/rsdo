import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Add_Admin extends StatefulWidget {
  const Add_Admin({super.key});

  @override
  State<Add_Admin> createState() => _Add_AdminState();
}

class _Add_AdminState extends State<Add_Admin> {

  TextEditingController user = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String myEmail = "moheb@gmail.com";
  String pass = "123";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/henrique.jpg'), fit: BoxFit.cover,opacity: 0.4 )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 35, top: 100),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontFamily: "RobotoSlab"
                      ),
                    ),Text(
                      ' Admin',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "RobotoSlab"
                      ),
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
                        controller: user,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff4c505b),
                          filled: true,
                          hintText: 'User name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),

                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                            " Save",
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
                              onPressed: () {
                                exportData();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Successfully added'),
                                  backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                                  showCloseIcon: true,
                                  duration: Duration(seconds: 2),
                                ));
                              },
                              icon: const Icon(Icons.how_to_reg_sharp, size: 30,),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
  void exportData() async {
    try {
      CollectionReference collRef = FirebaseFirestore.instance.collection('Accounts');

      collRef.add({
        'User name': user.text,
        'Email': email.text,
        'Password': password.text,
      });
    } catch (err) {
      print("There is some error");
    }
  }
}
