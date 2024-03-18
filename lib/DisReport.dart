import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class DisReport extends StatefulWidget {
  const DisReport({super.key});

  @override
  State<DisReport> createState() => _DisReportState();
}

class _DisReportState extends State<DisReport> {
  Future<String> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
  }

  Future<void> checkPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("OK")));
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('Location: ${position.latitude}, ${position.longitude}');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("NO")));
    }
  }

  List<String> _superMarketNames = ['Arg', 'Zaitoon','Rafa', 'Sohail','Safa', 'Mohandes Zada','Popal', 'Almas', 'Arzan Qimat', 'Roze-Herat', 'Siyawshani','Ansar', 'Amini', 'Anjeer', 'Salar','Korosh'];

  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    double fullScreenHeight = MediaQuery.of(context).size.height;
    final surveyorStream =
        FirebaseFirestore.instance.collection('Surveyor').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distributor report'),
        backgroundColor: const Color.fromRGBO(70, 130, 180, 1),
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: surveyorStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              final users =
                  snapshot.data?.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return data['NSuperMarket'];
              }).toList();
              return SizedBox(
                height: fullScreenHeight,
                width: fullScreenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(70, 130, 180, 0.1),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1.0,
                            blurRadius: 12,
                            offset: const Offset(
                                3.0, 2.0), // changes position of shadow
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15,
                            spreadRadius: 1.0,
                          )
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: _superMarketNames.length,
                        itemBuilder: (context, index) {
                          final storeName = _superMarketNames[index];
                          final totalStream = FirebaseFirestore.instance.collection('Paid').where('Store Name', isEqualTo: storeName).snapshots();
                          final femaleStream = FirebaseFirestore.instance.collection('Paid').where('Store Name', isEqualTo: storeName).where('Recipient Gender', isEqualTo: 'Female').snapshots();
                          final maleStream = FirebaseFirestore.instance.collection('Paid').where('Store Name', isEqualTo: storeName).where('Recipient Gender', isEqualTo: 'Male').snapshots();

                          totalStream.listen((querySnapshot) {
                            num total = 0;
                            for (var doc in querySnapshot.docs) {
                              total += doc.data()['amount']!; // Replace 'amount' with the field name of the amount to be summed
                            }
                            print('Total amount for $storeName: $total');
                          });

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                storeName,
                                style: const TextStyle(fontSize: 20),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: totalStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return const Text(
                                                'Something went wrong');
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text("Loading");
                                          }

                                          final total =
                                              snapshot.data?.docs.length;

                                          return Text(
                                            '$total',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          );
                                        },
                                      ),
                                      const Text("Total"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: femaleStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return const Text(
                                                'Something went wrong');
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text("Loading");
                                          }

                                          final female =
                                              snapshot.data?.docs.length;

                                          return Text(
                                            '$female',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          );
                                        },
                                      ),
                                      const Text("Female"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: maleStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return const Text(
                                                'Something went wrong');
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text("Loading");
                                          }

                                          final male =
                                              snapshot.data?.docs.length;

                                          return Text(
                                            '$male',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          );
                                        },
                                      ),
                                      const Text("Male"),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 1,
                                width: fullScreenWidth - 100,
                                color: Colors.grey,
                              )
                            ],
                          );
                        },
                      )),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
