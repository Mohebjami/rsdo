import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:download/download.dart';
import 'package:rsdo/MyData.dart';

class Export extends StatefulWidget {
  const Export({super.key});

  @override
  State<Export> createState() => _ExportState();
}

List<List<dynamic>> data = [];

class _ExportState extends State<Export> {
  @override
  Widget build(BuildContext context) {
    double fullScreenHeight = MediaQuery.of(context).size.height;
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: fullScreenWidth,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(47, 47, 94, 1),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                )),
            child: const Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  title: Text(
                    "RSDO",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: "RobotoSlab"),
                  ),
                  subtitle: Text(
                    "Good Morning",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "RobotoSlab"),
                  ),
                  trailing: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 50,
                      child: Image(
                        image: AssetImage("assets/logo.png"),
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () {
                // exportData();
                print("hello");
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Color.fromRGBO(47, 47, 94, 1),
                      ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ListTile(
                      title: const Text(
                        "Export Data",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "Send CSV file",
                        style: TextStyle(color: Colors.white),
                      ),
                      // set border for button
                      trailing: Image.asset(
                        "assets/upload.png",
                        width: 50,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'show');
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(47, 47, 94, 1),
                        Colors.blue,
                      ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ListTile(
                      title: const Text(
                        "See Data",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "See all Data",
                        style: TextStyle(color: Colors.white),
                      ),
                      // set border for button
                      trailing: Image.asset(
                        "assets/database-table.png",
                        width: 50,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'admin');
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Color.fromRGBO(47, 47, 94, 1),
                      ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ListTile(
                      title: const Text(
                        "Add Admin",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "Add new Admin",
                        style: TextStyle(color: Colors.white),
                      ),
                      // set border for button
                      trailing: Image.asset(
                        "assets/admin.png",
                        width: 50,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'sarver');
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(47, 47, 94, 1),
                        Colors.blue,
                      ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ListTile(
                      title: const Text(
                        "Add Client",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "Add new Client",
                        style: TextStyle(color: Colors.white),
                      ),
                      // set border for button
                      trailing: Image.asset(
                        "assets/Client.png",
                        width: 50,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'sarver');
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Color.fromRGBO(47, 47, 94, 1),
                      ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ListTile(
                      title: const Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "Delete all data",
                        style: TextStyle(color: Colors.white),
                      ),
                      // set border for button
                      trailing: Image.asset(
                        "assets/trash.png",
                        width: 50,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['csv']);

                if (result != null) {
                  final file = File(result.files.single.path!);
                  final contents = await file.readAsString();

                  try {
                    final List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(contents);
                    FirebaseFirestore.instance;
                    final firestoreInstance = FirebaseFirestore.instance;
                    for (final row in rowsAsListOfValues) {
                      print(row.length);
                      firestoreInstance.collection("Client").doc(row[row.length-1].toString()).set({
                        'S/N': row[0],
                        'Household ID': row[1],
                        'Household Name/Code': row[2],
                        'Recipient Name': row[3],
                        'Father Name': row[4],
                        'Recipient Gender': row[5],
                        'Document number': row[6],
                        'Alternate Recipient': row[7],
                        'Account Number': row[8],
                        'Household Size': row[9],
                        'Phone Number': row[10],
                        'Mobile Number': row[11],
                        'District': row[12],
                        'province': row[13],
                        'Location': row[14],
                        'Address': row[15],
                        'Amount': row[16],
                        'Store Name': row[17],
                        // Add more fields as needed
                      });
                    }
                    setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Inserted'),
                              content: const Text('All data inserted successfully'),
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
                    });


                    print("Data inserted");
                  } catch (err) {
                    print(err);
                  }
                }
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Color.fromRGBO(47, 47, 94, 1),
                      ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ListTile(
                      title: const Text(
                        "Download Data",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "Download data from paid table",
                        style: TextStyle(color: Colors.white),
                      ),
                      // set border for button
                      trailing: Image.asset(
                        "assets/download.png",
                        width: 50,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}