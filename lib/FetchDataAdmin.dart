import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rsdo/ClientInfo.dart';
import 'package:intl/intl.dart';
import 'package:rsdo/DisReport.dart';

class FetchDataAdmin extends StatelessWidget {
  const FetchDataAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return const FirebaseListView();
  }
}

class FirebaseListView extends StatefulWidget {
  const FirebaseListView({super.key});

  @override
  _FirebaseListViewState createState() => _FirebaseListViewState();
}

class _FirebaseListViewState extends State<FirebaseListView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  String _searchText = '';
  late var data;
  String dropdownValue = 'Household Name Code';

  void _search() {
    setState(() {
      _searchText = _textController.text;
    });
  }

  bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }


  //  void checkPermission() async {
  //    final status = await Permission.location.request();
  //    if (status.isGranted) {
  //      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OK")));
  //      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //      Cposition =  [position.latitude, position.longitude];
  //    } else {
  //      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("NO")));
  //    }
  //
  // }





  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    // double fullScreenHeight = MediaQuery.of(context).size.height;
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(230, 240, 255, 0.9),
        appBar: AppBar(
          title: const Text('Clients'),
          backgroundColor: const Color.fromRGBO(70, 130, 180, 1),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Paid')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text("Loading");
                                        }
                                        int? docLength = snapshot.data?.docs
                                            .length; // Assigning length to a variable
                                        // Printing the length
                                        return Text(
                                          '$docLength',
                                          style: const TextStyle(
                                              color: Colors.black,
                                          fontSize: 25),
                                        );
                                      },
                                    ),
                                    const Text("Total"),
                                  ],
                                ),
                                const SizedBox(width: 30,),
                                Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Paid')
                                          .where('Recipient Gender',
                                              isEqualTo: 'Female')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text("Loading");
                                        }
                                        int? docLength = snapshot.data?.docs
                                            .length; // Assigning length to a variable
                                        // Printing the length
                                        return Text(
                                          '$docLength',
                                          style: const TextStyle(
                                              color: Colors.black,fontSize: 25),
                                        );
                                      },
                                    ),
                                    const Text("Female"),
                                  ],
                                ),
                                const SizedBox(width: 30,),
                                Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection('Paid').where('Recipient Gender', isEqualTo: 'Male')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text("Loading");
                                        }
                                        int? docLength = snapshot.data?.docs
                                            .length; // Assigning length to a variable
                                        // Printing the length
                                        return Text(
                                          '$docLength',
                                          style: const TextStyle(
                                              color: Colors.black,fontSize: 25),
                                        );
                                      },
                                    ),
                                    const Text("Male"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(onPressed: (){
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => const DisReport()),
                              );
                            }, child: const Text("See more", style: TextStyle(color:  Color.fromRGBO(70, 130, 180, 1),fontSize: 15),))
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.insert_chart_outlined_rounded,
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: fullScreenWidth,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(70, 130, 180, 1),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 5.0, top: 5.0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    focusColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.white), // Change color here
                    dropdownColor: const Color.fromRGBO(70, 130, 180, 1),
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Household Name Code', 'Account Number']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: const Color.fromRGBO(70, 130, 180, 0.9),
                  filled: true,
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: _search,
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('Clients')
                    .where(dropdownValue,
                        isEqualTo: dropdownValue == 'Account Number' && isNumeric(_searchText) ? int.parse(_searchText) : _searchText).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;CollectionReference paid = FirebaseFirestore.instance.collection('Paid');
                      var sn = data['SN'];
                      var householdId = data['Household ID'];
                      var householdNameCode = data['Household Name Code'];
                      var recipientName = data['Recipient Name'];
                      var recipientLastName = data['Recipient Last Name'];
                      var fatherName = data['Father Name'];
                      var recipientGender = data['Recipient Gender'];
                      var recipientDocumentList =
                          data['Recipient Document List'];
                      var phoneNumber = data['Phone Number'];
                      var mobileNumber = data['Mobile Number'];
                      var tazkiraNumber = data['Tazkira Number'];
                      var alternateRecipient = data['Alternate Recipient'];
                      var accountNumber = data['Account Number'];
                      var Location = data['Location'];
                      var Address = data['Address'];
                      var province = data['province'];
                      var District = data['District'];
                      var Amount = data['Amount'];
                      var ss = "Paid with Admin";
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Slidable(
                              closeOnScroll: true,
                              startActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                        borderRadius: BorderRadius.circular(15),
                                        backgroundColor: Colors.green,
                                        icon: Icons.check,
                                        label: 'Paid',
                                        onPressed: (context) async {
                                          // checkPermission();
                                          // print("------------");
                                          // print(Cposition);
                                          late var Cposition;
                                          final status = await Permission.location.request();
                                          if (status.isGranted) {
                                            Position  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                                            Cposition =  [position.latitude, position.longitude];
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("NO")));
                                          }
                                          try {
                                            var querySnapshot = await FirebaseFirestore.instance.collection('Paid').where('Household ID', isEqualTo: householdId).get();
                                            if (querySnapshot.docs.isEmpty) {
                                            print("-----------------------------");
                                              print(Cposition);
                                              await paid.add({
                                                'S/N': sn,
                                                'Household ID': householdId,
                                                'Household Name Code':
                                                    householdNameCode,
                                                'Recipient Name': recipientName,
                                                'Recipient Last Name':
                                                    recipientLastName,
                                                'Father Name': fatherName,
                                                'Recipient Gender':
                                                    recipientGender,
                                                'Recipient Document List':
                                                    recipientDocumentList,
                                                'Phone Number': phoneNumber,
                                                'Mobile Number': mobileNumber,
                                                'Tazkira Number': tazkiraNumber,
                                                'Alternate Recipient':
                                                    alternateRecipient,
                                                'Account Number': accountNumber,
                                                'Location': Location,
                                                'Address': Address,
                                                'province': province,
                                                'District': District,
                                                'Amount': Amount,
                                                'Store Name': ss,
                                                'Current time': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                                                'Cposition': Cposition.toString(),
                                              }).then((value) {
                                                _scaffoldMessengerKey
                                                    .currentState
                                                    ?.showSnackBar(SnackBar(
                                                  content: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    height: 90,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      "Successfully Paid",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )),
                                                  ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0.0,
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ));
                                              }).catchError((error) {
                                                if (mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text("$error"),
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            47, 47, 94, 1),
                                                    showCloseIcon: true,
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  ));
                                                }
                                              });
                                            } else {
                                              _scaffoldMessengerKey.currentState
                                                  ?.showSnackBar(SnackBar(
                                                content: Container(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  height: 90,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                  ),
                                                  child: const Center(
                                                      child: Text(
                                                    "Already Paid",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )),
                                                ),
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0.0,
                                                duration:
                                                    const Duration(seconds: 2),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ));
                                            }
                                          } catch (e) {
                                            print('Failed to add document: $e');
                                          }
                                        })
                                  ]),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(70, 130, 180, 0.9),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(70, 130, 180, 0.9),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  title: Text(
                                    data['Recipient Name'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    data['Alternate Recipient'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: Text(
                                    data['SN'].toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromRGBO(230, 240, 255, 0.9),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    data['Account Number'].toString().substring(
                                        data['Account Number']
                                                .toString()
                                                .length -
                                            5),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ClientInfo(data: data),
                                      ),
                                    );
                                  },
                                ),
                              )),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
