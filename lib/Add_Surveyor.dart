import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add_Sarver extends StatefulWidget {
  const Add_Sarver({super.key});

  @override
  State<Add_Sarver> createState() => _Add_SarverState();
}

class _Add_SarverState extends State<Add_Sarver> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String imageUrl='';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/henrique.jpg'),
              fit: BoxFit.cover,
              opacity: 0.2)),
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
                          fontFamily: "RobotoSlab"),
                    ),
                    Text(
                      'Distributor',
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
                                email.clear();
                                password.clear();
                              },
                              icon: const Icon(
                                Icons.how_to_reg_sharp,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  void exportData() async {
    try {
      String emailText = email.text;
      String passwordText = password.text;

// Check if the fields are empty or contain certain symbols
      if (emailText.isEmpty || passwordText.isEmpty || emailText.contains(RegExp(r'[/\\"|]')) ||
          passwordText.contains(RegExp(r'[/\\"|]'))) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Error',
                  style: TextStyle(color: Colors.red),
                ),
                icon: const Image(
                  image: AssetImage("assets/no-wifi.png"),
                  width: 35,
                  height: 35,
                ),
                iconColor: Colors.red,
                content: const Text(
                    'You cant ues from this Signs ( /\\"| ) or empty',
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
        CollectionReference collRef = FirebaseFirestore.instance.collection('Surveyor');
        collRef.add({
          'User Name': emailText,
          'Password': passwordText,
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully added'),
          backgroundColor: Color.fromRGBO(47, 47, 94, 1),
          showCloseIcon: true,
          duration: Duration(seconds: 2),
        ));
      }
    } catch (err) {
      print("There is some error");
    }
  }
}
