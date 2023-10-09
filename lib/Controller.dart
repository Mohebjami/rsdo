import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;
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
            child: AbsorbPointer(
              absorbing: shouldAbsorb,
              child: GestureDetector(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom, allowedExtensions: ['csv']);
                  setState(() {
                    showDialog(context: context, builder: (context){
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.grey,
                        ),
                      );
                    });
                  });
                  if (result != null) {
                    final file = File(result.files.single.path!);
                    final contents = await file.readAsString();
                    try {
                      final List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(contents);
                      FirebaseFirestore.instance;
                       final firestoreInstance = FirebaseFirestore.instance;
                      for (final row in rowsAsListOfValues) {
                       await firestoreInstance.collection("Clients").doc().set({
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
                        "See Data Client",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "See all Data Client",
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
                Navigator.pushNamed(context, 'FetchPaidData');
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
                        "See Data Paid",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "See all Data Paid",
                        style: TextStyle(color: Colors.white),
                      ),
                      // set border for button
                      trailing: Image.asset(
                          "assets/paid.png",
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
                Navigator.pushNamed(context, 'Surveyor');
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
                        "Add Surveyor",
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete All Data',
                          style: TextStyle(color: Colors.red)),
                      content:
                          const Text('Are you sure you want to delete all data?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform the action if the user confirms
                            deleteAllDocuments();
                            Navigator.of(context).pop();
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(13, 110, 253, 1)),
                            overlayColor: MaterialStatePropertyAll(
                                Color.fromRGBO(153, 217, 234, 0.2)),
                          ),
                          child: const Text('Confirm',
                              style: TextStyle(color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () {
                            // Close the dialog if the user cancels
                            Navigator.of(context).pop();
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(13, 110, 253, 1)),
                            // overlayColor: MaterialStatePropertyAll(Color.fromRGBO(153, 217, 234, 0.2)),
                          ),
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  },
                );
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
                        "Delete Clients",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "Delete all data of Clients",
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete All Data',
                          style: TextStyle(color: Colors.red)),
                      content:
                      Text('Are you sure you want to delete all data?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform the action if the user confirms
                            deleteAllDocumentsPaid();
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(13, 110, 253, 1)),
                            overlayColor: MaterialStatePropertyAll(
                                Color.fromRGBO(153, 217, 234, 0.2)),
                          ),
                          child: Text('Confirm',
                              style: TextStyle(color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () {
                            // Close the dialog if the user cancels
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(13, 110, 253, 1)),
                            // overlayColor: MaterialStatePropertyAll(Color.fromRGBO(153, 217, 234, 0.2)),
                          ),
                          child: Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  },
                );
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
                        "Delete Paid",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "RobotoSlab"),
                      ),
                      subtitle: const Text(
                        "Delete all data of paid table",
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
              onTap: () {
                createExcel();
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

  Future createExcel() async {
    var data;
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
      sheet.getRangeByName('B$excelRow').setText(data['Household ID'].toString());
      sheet.getRangeByName('C$excelRow').setText(data['Household Name Code']);
      sheet.getRangeByName('D$excelRow').setText(data['Recipient Name']);
      sheet.getRangeByName('E$excelRow').setText(data['Recipient Last Name']);
      sheet.getRangeByName('F$excelRow').setText(data['Father Name']);
      sheet.getRangeByName('G$excelRow').setText(data['Recipient Gender']);
      sheet.getRangeByName('H$excelRow').setText(data['Recipient Document List']);
      sheet.getRangeByName('I$excelRow').setText(data['Phone Number'].toString());
      sheet.getRangeByName('J$excelRow').setText(data['Mobile Number'].toString());
      sheet.getRangeByName('K$excelRow').setText(data['Account Number'].toString());
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
