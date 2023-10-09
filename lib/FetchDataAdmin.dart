import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FetchDataAdmin extends StatefulWidget {
  const FetchDataAdmin({super.key});

  @override
  State<FetchDataAdmin> createState() => _FetchDataAdminState();
}

class _FetchDataAdminState extends State<FetchDataAdmin> {
  late var client, id, clients, data, data2;
  bool isPaid = true;
  var name = "";
  @override
  Widget build(BuildContext context) {
    double fullScreenHeight = MediaQuery.of(context).size.height;
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Clients"),
        backgroundColor: const Color.fromRGBO(47, 47, 94, 1),
      ),
      body: Container(
        height: fullScreenHeight,
        width: fullScreenWidth,
        decoration: const BoxDecoration(),
        child: Stack(children: [
          const SizedBox(
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
                  FirebaseFirestore.instance.collection('Clients').snapshots(),
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
                              if (data['Household Name Code']
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(name.toLowerCase()) ||
                                  data['Mobile Number']
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(name.toLowerCase())) {
                                data2 = snapshots.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                final CollectionReference client =
                                    FirebaseFirestore.instance
                                        .collection("Paid");
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
                                                  'S/N': data2['SN'],
                                                  'Household ID': data2['Household ID'],
                                                  'Household Name Code': data2['Household Name Code'],
                                                  'Recipient Name': data2['Recipient Name'],
                                                  'Recipient Last Name': data2['Recipient Last Name'],
                                                  'Father Name': data2['Father Name'],
                                                  'Recipient Gender': data2['Recipient Gender'],
                                                  'Recipient Document List': data2['Recipient Document List'],
                                                  'Phone Number': data2['Phone Number'],
                                                  'Mobile Number': data2['Mobile Number'],
                                                  'Account Number': data2['Account Number'],
                                                  'Alternate Recipient': data2['Alternate Recipient'],
                                                  'Address': data2['Address'],
                                                  'Region': data2['Region'],
                                                  'province': data2['province'],
                                                  'District': data2['District'],
                                                  'Amount': data2['Amount'],
                                                  'Store Name': "Paid with Admin",
                                                };
                                                client.add(record);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text('Paid'),
                                                  backgroundColor:
                                                      Color.fromRGBO(
                                                          47, 47, 94, 1),
                                                  showCloseIcon: true,
                                                  duration:
                                                      Duration(seconds: 2),
                                                ));
                                              } catch (err) {
                                                print(err);
                                              }
                                            })
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
        onPressed: () async {
          //
          // Call the function to check for duplicate data
          final isDuplicate = await checkForDuplicateData(name);

          // If duplicate data is found, disable the paid button
          if (isDuplicate) {
            // Disable the paid button
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('duplicate'),
                      content: const Text("This data is duplicate"),
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
            });
            setState(() {
              isPaid = false;
            });
          } else {
            // Enable the paid button
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Not duplicate'),
                      content: const Text("This data is Not duplicate"),
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
            });
            setState(() {
              isPaid = true;
            });
          }
        },
        color: const Color.fromRGBO(13, 110, 253, 1),
        hoverColor: const Color.fromRGBO(153, 217, 234, 0.2),
        child: const Text(
          "Cheek duplicate",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// Function to check for duplicate data in Firebase
Future<bool> checkForDuplicateData(String clientId) async {
  bool isDuplicate = false;

  // Assuming you have two tables in Firebase named 'table1' and 'table2'
  final table1Ref = FirebaseFirestore.instance.collection('Clients');
  final table2Ref = FirebaseFirestore.instance.collection('Paid');

  // Query the tables for data with the specified clientId
  final table1Snapshot =
      await table1Ref.where('Household Name Code', isEqualTo: clientId).get();
  final table2Snapshot =
      await table2Ref.where('Household Name Code', isEqualTo: clientId).get();

  // Check if data was found in both tables
  if (table1Snapshot.docs.isNotEmpty && table2Snapshot.docs.isNotEmpty) {
    isDuplicate = true;
  }

  // Return the result
  return isDuplicate;
}
