import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}



class _FetchDataState extends State<FetchData> {
  late DocumentReference _documentReference;
  late var client, id, clients, data, data2;
  bool isPaid = true;
  var name = "";
  @override
  Widget build(BuildContext context) {
    double fullScreenHeight = MediaQuery.of(context).size.height;
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: const Color.fromRGBO(47, 47, 94, 1),
      ),
      body: Container(
        height: fullScreenHeight,
        width: fullScreenWidth,
        decoration: BoxDecoration(),
        child: Stack(children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search...'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Client').snapshots(),

              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 65.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              data = snapshots.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              clients = snapshots.data?.docs.reversed.toList();
                              if (name.isEmpty) {
                                return ListTile(
                                  title: Text(
                                    data['Recipient Name'],
                                  ),
                                  subtitle: Text(
                                    data['Father Name'],
                                  ),
                                );
                              }
                              if (data['Recipient Name'].toString().toLowerCase().startsWith(name.toLowerCase()) || data['Mobile Number'].toString().toLowerCase().startsWith(name.toLowerCase())) {
                                data2 = snapshots.data!.docs[index].data() as Map<String, dynamic>;
                                final CollectionReference client = FirebaseFirestore.instance.collection("Paid");
                                return Slidable(
                                  enabled: isPaid,
                                  closeOnScroll: true,
                                  startActionPane: ActionPane(
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          backgroundColor: Colors.red,
                                          icon: Icons.check,
                                          label: 'Paid',
                                          onPressed: (context) async {
                                                    try {
                                                      var record = {
                                                        'S/N': data2['S/N'],
                                                        'Household ID':
                                                        data2['Household ID'],
                                                        'Household Name/Code': data2[
                                                        'Household Name/Code'],
                                                        'Recipient Name':
                                                        data2['Recipient Name'],
                                                        'Father Name':
                                                        data2['Father Name'],
                                                        'Recipient Gender':
                                                        data2['Recipient Gender'],
                                                        'Document number':
                                                        data2['Document number'],
                                                        'Alternate Recipient': data2[
                                                        'Alternate Recipient'],
                                                        'Account Number':
                                                        data2['Account Number'],
                                                        'Household Size':
                                                        data2['Household Size'],
                                                        'Phone Number':
                                                        data2['Phone Number'],
                                                        'Mobile Number':
                                                        data2['Mobile Number'],
                                                        'Location': data2['Location'],
                                                        'Address': data2['Address'],
                                                        'District': data2['District'],
                                                        'province': data2['province'],
                                                        'Amount': data2['Amount'],
                                                        'Store Name':
                                                        data2['Store Name'],
                                                      };
                                                      client.add(record);
                                                      print("Paid");

                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(const SnackBar(
                                                        content: Text('Paid'),
                                                        backgroundColor: Color.fromRGBO(
                                                            47, 47, 94, 1),
                                                        showCloseIcon: true,
                                                        duration: Duration(seconds: 2),
                                                      ));
                                                    } catch (err) {
                                                      print(err);
                                                    }
                                            }
                                        )
                                      ]),
                                  child: ListTile(
                                    title: Text(
                                      data['Recipient Name'],
                                    ),
                                    subtitle: Text(
                                      data['Father Name'],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      );
              }),
        ]),
      ),
      floatingActionButton: MaterialButton(
        onPressed: () async{
          // print("2");
          //
          // // Call the function to check for duplicate data
          // final isDuplicate = await checkForDuplicateData(name);
          //
          // // If duplicate data is found, disable the paid button
          // if (isDuplicate) {
          //   // Disable the paid button
          //   print("================================== data found");
          //   setState(() {
          //     isPaid = false;
          //   });
          // } else {
          //   // Enable the paid button
          //   print("================================== data Not found");
          //   setState(() {
          //     isPaid = true;
          //   });
          // }
        },
        child: Text("click it"),
      ),
    );
  }

  void SerachData() async {

    print("2");

    // Call the function to check for duplicate data
    final isDuplicate = await checkForDuplicateData(name);

    // If duplicate data is found, disable the paid button
    if (isDuplicate) {
      // Disable the paid button
      print("================================== data found");
      setState(() {
        isPaid = false;
      });
    } else {
      // Enable the paid button
      print("================================== data Not found");
      setState(() {
        isPaid = true;
      });
    }

  }
}

// Function to check for duplicate data in Firebase
Future<bool> checkForDuplicateData(String clientId) async {
  bool isDuplicate = false;

  // Assuming you have two tables in Firebase named 'table1' and 'table2'
  final table1Ref = FirebaseFirestore.instance.collection('Client');
  final table2Ref = FirebaseFirestore.instance.collection('Paid');

  // Query the tables for data with the specified clientId
  final table1Snapshot = await table1Ref.where('Recipient Name', isEqualTo: clientId).get();
  final table2Snapshot = await table2Ref.where('Recipient Name', isEqualTo: clientId).get();

  // Check if data was found in both tables
  if (table1Snapshot.docs.isNotEmpty && table2Snapshot.docs.isNotEmpty) {
    isDuplicate = true;
  }

  // Return the result
  return isDuplicate;
}


