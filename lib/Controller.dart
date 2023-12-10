import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:flutter/material.dart';

class Export extends StatefulWidget {
  const Export({super.key});

  @override
  State<Export> createState() => _ExportState();
}

List<List<dynamic>> data = [];

class _ExportState extends State<Export> {
  bool shouldAbsorb = false;
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(211, 211, 211, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
           const SizedBox(
              height: 40,
            ),
            Container(
              width: fullScreenWidth,
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  )
              ),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90, // specify the width
                          height: 90, // specify the height
                          child: Image(
                            image: AssetImage("assets/logo.png"),
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "RSDO",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: "RobotoSlab"),
                            ),
                            Text(
                              "Good Morning",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "RobotoSlab"),
                            ),
                          ],
                        )

                      ],
                    ),
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
            Row(
              children: [
                // new buttons
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    height: 230,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 12,
                                    blurRadius: 20,
                                    offset: const Offset(-0, 0),
                                    blurStyle: BlurStyle
                                        .inner // changes position of shadow
                                    ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 1.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        3.0, 2.0), // changes position of shadow
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              width: 50,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image(
                                  image: AssetImage("assets/senddata.png"),
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text("Export Data"),
                        ElevatedButton(
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['csv']);
                            if (result != null) {
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
                              final file = File(result.files.single.path!);
                              final contents = await file.readAsString();
                              try {
                                final List<List<dynamic>> rowsAsListOfValues =
                                    const CsvToListConverter()
                                        .convert(contents);
                                FirebaseFirestore.instance;
                                final firestoreInstance =
                                    FirebaseFirestore.instance;
                                for (final row in rowsAsListOfValues) {
                                  await firestoreInstance
                                      .collection("Clients")
                                      .doc()
                                      .set({
                                    'SN': row[0],
                                    'Household ID': row[1],
                                    'Household Name Code': row[2],
                                    'Recipient Name': row[3],
                                    'Recipient Last Name': row[4],
                                    'Father Name': row[5],
                                    'Recipient Gender': row[6],
                                    'Recipient Document List': row[7],
                                    'Phone Number': row[8],
                                    'Mobile Number': row[9],
                                    'Account Number': row[10],
                                    'Alternate Recipient': row[11],
                                    'Address': row[12],
                                    'Region': row[13],
                                    'province': row[14],
                                    'District': row[15],
                                    'Amount': row[16],
                                    // Add more fields as needed
                                  });
                                }

                                Navigator.pop(context);
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Inserted'),
                                          content: const Text(
                                              'All data inserted successfully'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Done'),
                                              onPressed: () {
                                                setState(() {
                                                  shouldAbsorb = true;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                });
                              } catch (err) {
                                AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'There is some error'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        setState(() {
                                          shouldAbsorb = true;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.red))),
                          ),
                          child: const Text('Select File'),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    height: 230,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 12,
                                    blurRadius: 20,
                                    offset: const Offset(-0, 0),
                                    blurStyle: BlurStyle
                                        .inner // changes position of shadow
                                    ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 1.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        3.0, 2.0), // changes position of shadow
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              width: 50,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image(
                                  image: AssetImage("assets/analytics.png"),
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text("Report"),
                        ElevatedButton(
                          onPressed: () {
                            createExcel();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.red))),
                          ),
                          child: const Text('Download'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    height: 230,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 12,
                                    blurRadius: 20,
                                    offset: const Offset(-0, 0),
                                    blurStyle: BlurStyle
                                        .inner // changes position of shadow
                                    ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 1.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        3.0, 2.0), // changes position of shadow
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              width: 50,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image(
                                  image: AssetImage("assets/Clinet.png"),
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text("Clients"),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'show');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.red))),
                          ),
                          child: const Text('Search Clients'),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    height: 230,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 12,
                                    blurRadius: 20,
                                    offset: const Offset(-0, 0),
                                    blurStyle: BlurStyle
                                        .inner // changes position of shadow
                                    ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 1.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        3.0, 2.0), // changes position of shadow
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              width: 50,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image(
                                  image: AssetImage("assets/paid.png"),
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text("Paid ones"),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'FetchPaidData');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.red))),
                          ),
                          child: const Text('Search'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    height: 230,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 12,
                                    blurRadius: 20,
                                    offset: const Offset(-0, 0),
                                    blurStyle: BlurStyle
                                        .inner // changes position of shadow
                                    ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 1.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        3.0, 2.0), // changes position of shadow
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              width: 50,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image(
                                  image: AssetImage("assets/admin.png"),
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text("New Admin"),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'admin');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.red))),
                          ),
                          child: const Text('Add'),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    height: 230,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 12,
                                    blurRadius: 20,
                                    offset: const Offset(-0, 0),
                                    blurStyle: BlurStyle
                                        .inner // changes position of shadow
                                    ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 1.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        3.0, 2.0), // changes position of shadow
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              width: 50,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image(
                                  image: AssetImage("assets/surveyr.png"),
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text("New Surveyor"),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'Surveyor');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.red))),
                          ),
                          child: const Text('Add'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    height: 230,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 12,
                                    blurRadius: 20,
                                    offset: const Offset(-0, 0),
                                    blurStyle: BlurStyle
                                        .inner // changes position of shadow
                                    ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 1.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        3.0, 2.0), // changes position of shadow
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              width: 50,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image(
                                  image: AssetImage("assets/trash.png"),
                                  width: 130,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text("Delete Clients"),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete All Data',
                                      style: TextStyle(color: Colors.red)),
                                  content: const Text(
                                      'Are you sure you want to delete all data?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog if the user cancels
                                        Navigator.of(context).pop();
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromRGBO(
                                                    13, 110, 253, 1)),
                                        // overlayColor: MaterialStatePropertyAll(Color.fromRGBO(153, 217, 234, 0.2)),
                                      ),
                                      child: const Text('Cancel',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Perform the action if the user confirms
                                        setState(() {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });
                                        });
                                        deleteAllDocuments();
                                        Navigator.of(context).pop();
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromRGBO(
                                                    13, 110, 253, 1)),
                                        overlayColor: MaterialStatePropertyAll(
                                            Color.fromRGBO(153, 217, 234, 0.2)),
                                      ),
                                      child: const Text('Confirm',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.red))),
                          ),
                          child: const Text('Delete'),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    height: 230,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 12,
                                    blurRadius: 20,
                                    offset: const Offset(-0, 0),
                                    blurStyle: BlurStyle
                                        .inner // changes position of shadow
                                    ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 1.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        3.0, 2.0), // changes position of shadow
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-3.0, -3.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              width: 50,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image(
                                  image: AssetImage("assets/recycle-bin.png"),
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text("Delete Paid"),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete All Data',
                                      style: TextStyle(color: Colors.red)),
                                  content: const Text(
                                      'Are you sure you want to delete all data?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog if the user cancels
                                        Navigator.of(context).pop();
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromRGBO(
                                                    13, 110, 253, 1)),
                                        // overlayColor: MaterialStatePropertyAll(Color.fromRGBO(153, 217, 234, 0.2)),
                                      ),
                                      child: const Text('Cancel',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Perform the action if the user confirms
                                        deleteAllDocumentsPaid();
                                        Navigator.of(context).pop();
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromRGBO(
                                                    13, 110, 253, 1)),
                                        overlayColor: MaterialStatePropertyAll(
                                            Color.fromRGBO(153, 217, 234, 0.2)),
                                      ),
                                      child: const Text('Confirm',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.red))),
                          ),
                          child: const Text('Delete'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future createExcel() async {
    Map<String, dynamic> data;
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Paid').get();
    int i = 0;
    int excelRow = 2;
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('S/N');
    sheet.getRangeByName('B1').setText('Household ID');
    sheet.getRangeByName('C1').setText('Household Name');
    sheet.getRangeByName('D1').setText('Recipient First Name');
    sheet.getRangeByName('E1').setText('Recipient Last Name');
    sheet.getRangeByName('F1').setText('Father Name');
    sheet.getRangeByName('G1').setText('Recipient Gender');
    sheet.getRangeByName('H1').setText('Recipient Document List');
    sheet.getRangeByName('I1').setText('Mobile Number');
    sheet.getRangeByName('J1').setText('Recipient Mobile Number');
    sheet.getRangeByName('K1').setText('Account Number');
    sheet.getRangeByName('L1').setText('Alternate Recipient');
    sheet.getRangeByName('M1').setText('Address');
    sheet.getRangeByName('N1').setText('Region');
    sheet.getRangeByName('O1').setText('province');
    sheet.getRangeByName('P1').setText('District');
    sheet.getRangeByName('Q1').setText('Amount');
    sheet.getRangeByName('R1').setText('Store Name');
    while (i < snapshot.docs.length) {
      data = snapshot.docs[i].data() as Map<String, dynamic>;
      sheet.getRangeByName('A$excelRow').setText(data['S/N'].toString());
      sheet
          .getRangeByName('B$excelRow')
          .setText(data['Household ID'].toString());
      sheet.getRangeByName('C$excelRow').setText(data['Household Name Code']);
      sheet.getRangeByName('D$excelRow').setText(data['Recipient Name']);
      sheet.getRangeByName('E$excelRow').setText(data['Recipient Last Name']);
      sheet.getRangeByName('F$excelRow').setText(data['Father Name']);
      sheet.getRangeByName('G$excelRow').setText(data['Recipient Gender']);
      sheet
          .getRangeByName('H$excelRow')
          .setText(data['Recipient Document List']);
      sheet
          .getRangeByName('I$excelRow')
          .setText(data['Phone Number'].toString());
      sheet
          .getRangeByName('J$excelRow')
          .setText(data['Mobile Number'].toString());
      sheet
          .getRangeByName('K$excelRow')
          .setText(data['Account Number'].toString());
      sheet.getRangeByName('L$excelRow').setText(data['Alternate Recipient']);
      sheet.getRangeByName('M$excelRow').setText(data['Address'].toString());
      sheet.getRangeByName('N$excelRow').setText(data['Region']);
      sheet.getRangeByName('O$excelRow').setText(data['province']);
      sheet.getRangeByName('P$excelRow').setText(data['District']);
      sheet.getRangeByName('Q$excelRow').setText(data['Amount'].toString());
      sheet.getRangeByName('R$excelRow').setText(data['Store Name']);
      i++;
      excelRow++;
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    var path = await AndroidPathProvider.downloadsPath;
    final String fileName = '$path/Report.xlsx';
    final File file = File(fileName);
    await file
        .writeAsBytes(bytes, flush: true)
        .then((_) => setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Successfully'),
                      content: const Text("Report file successfully created"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Done'),
                          onPressed: () {
                            setState(() {
                              shouldAbsorb = false;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }))
        .catchError((error) => setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Failed'),
                      content: Text("$error"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Done'),
                          onPressed: () {
                            setState(() {
                              shouldAbsorb = false;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }));
  }

  Future<void> deleteAllDocuments() async {
    FirebaseFirestore.instance
        .collection('Clients')
        .get()
        .then((snapshot) {
          for (DocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        })
        .then((_) => setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Successfully'),
                      content: const Text('All data Deleted successfully'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Done'),
                          onPressed: () {
                            setState(() {
                              shouldAbsorb = false;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }))
        .catchError((error) => setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Failed to delete data'),
                      content: Text("$error"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Done'),
                          onPressed: () {
                            setState(() {
                              shouldAbsorb = false;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }));
    Navigator.of(context).pop();
  }

  Future<void> deleteAllDocumentsPaid() async {
    setState(() {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    });

    FirebaseFirestore.instance
        .collection('Paid')
        .get()
        .then((snapshot) {
          for (DocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        })
        .then((_) => setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Successfully'),
                      content: const Text('All data Deleted successfully'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Done'),
                          onPressed: () {
                            setState(() {
                              shouldAbsorb = false;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }))
        .catchError((error) => setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Failed to delete data'),
                      content: Text("$error"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Done'),
                          onPressed: () {
                            setState(() {
                              shouldAbsorb = false;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }));
    Navigator.of(context).pop();
  }
}
