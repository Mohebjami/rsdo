import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String myEmail = "moheb";
  String pass = "123";

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
                        onPressed: () {
                          // if (myEmail == email.text && pass == password.text) {
                            Navigator.pushNamed(context, "export");
                          // } else {
                          //   ScaffoldMessenger.of(context)
                          //       .showSnackBar(const SnackBar(
                          //     content: Text('Wrong username or password'),
                          //     backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                          //     showCloseIcon: true,
                          //     duration: Duration(seconds: 2),
                          //   ));
                          // }
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


  // late var client,id,clients,data;
  // String name = "";
  // void getData(){
  //   print("1");
  //   var data = FirebaseFirestore.instance.collection('Accounts').snapshots();
  //   (context, snapshots) {
  //     data = snapshots.data!.data() as Stream<QuerySnapshot<Map<String, dynamic>>>;
  //     clients = snapshots.data?.docs.reversed.toList();
  //     if(name.isEmpty){
  //       print(data['Email']);
  //     }
  //     if(data['Recipient Name'].toString().toLowerCase().startsWith(name.toLowerCase())){
  //       return ListTile(
  //         title: Text(
  //           data['Recipient Name'],
  //         ),
  //         subtitle: Text(
  //           data['Father Name'],
  //         ),
  //       );
  //     }
  //     return Container();
  //   },
  // }



}

//   void getData() {
//     print('1');
//     StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('Accounts').snapshots(),
//         builder: (context, snapshots) {
//           List<Row> clientWidgets = [];
//           if (snapshots.hasData) {
//             final clients = snapshots.data?.docs.reversed.toList();
//             for (var client in clients!) {
//               print(client['Email']);
//             }
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: Text('Empty'),
//               backgroundColor: Color.fromRGBO(47, 47, 94, 1),
//               showCloseIcon: true,
//               duration: Duration(seconds: 2),
//             ));
//           }
//           return Expanded(
//             child: ListView(children: clientWidgets),
//           );
//         });
//     print('End');
//   }
// }
