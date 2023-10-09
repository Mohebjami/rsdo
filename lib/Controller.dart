import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
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
            child: AbsorbPointer(
              absorbing: shouldAbsorb,
              child: GestureDetector(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
                  setState(() {
                    showDialog(context: context, builder: (context){
                      return Center(
                        child: CircularProgressIndicator(),
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
                        print(row.length);
                        await firestoreInstance.collection("Client").doc(row[row.length-1].toString()).set({
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
                      Navigator.pop(context);
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
                                      setState(() {
                                        shouldAbsorb = true;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                        );
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
                deleteAllDocuments();
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
              onTap: ()  {
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
      var data,clients;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Paid').get();
    int i =0;
    int excelRow = 2;
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
      sheet.getRangeByName('A1').setText('S/N');
      sheet.getRangeByName('B1').setText('Household ID');
      sheet.getRangeByName('C1').setText('Household Name/Code');
      sheet.getRangeByName('D1').setText('Recipient Name');
      sheet.getRangeByName('E1').setText('Father Name');
      sheet.getRangeByName('F1').setText('Recipient Gender');
      sheet.getRangeByName('G1').setText('Document number');
      sheet.getRangeByName('H1').setText('Alternate Recipient');
      sheet.getRangeByName('I1').setText('Account Number');
      sheet.getRangeByName('J1').setText('Household Size');
      sheet.getRangeByName('K1').setText('Phone Number');
      sheet.getRangeByName('L1').setText('Mobile Number');
      sheet.getRangeByName('O1').setText('District');
      sheet.getRangeByName('P1').setText('province');
      sheet.getRangeByName('M1').setText('Location');
      sheet.getRangeByName('N1').setText('Address');
      sheet.getRangeByName('Q1').setText('Amount');
      sheet.getRangeByName('R1').setText('Store Name');
    while(i< snapshot.docs.length){
      data = snapshot.docs[i].data() as Map<String, dynamic>;
      clients = snapshot.docs.reversed.toList();
      sheet.getRangeByName('A$excelRow').setText(data['S/N'].toString());
      sheet.getRangeByName('B$excelRow').setText(data['Household ID'].toString());
      sheet.getRangeByName('C$excelRow').setText(data['Household Name/Code']);
      sheet.getRangeByName('D$excelRow').setText(data['Recipient Name']);
      sheet.getRangeByName('E$excelRow').setText(data['Father Name']);
      sheet.getRangeByName('F$excelRow').setText(data['Recipient Gender']);
      sheet.getRangeByName('G$excelRow').setText(data['Document number']);
      sheet.getRangeByName('H$excelRow').setText(data['Alternate Recipient']);
      sheet.getRangeByName('I$excelRow').setText(data['Account Number'].toString());
      sheet.getRangeByName('J$excelRow').setText(data['Household Size'].toString());
      sheet.getRangeByName('K$excelRow').setText(data['Phone Number'].toString());
      sheet.getRangeByName('L$excelRow').setText(data['Mobile Number'].toString());
      sheet.getRangeByName('O$excelRow').setText(data['District']);
      sheet.getRangeByName('P$excelRow').setText(data['province']);
      sheet.getRangeByName('M$excelRow').setText(data['Location']);
      sheet.getRangeByName('N$excelRow').setText(data['Address'].toString());
      sheet.getRangeByName('Q$excelRow').setText(data['Amount'].toString());
      sheet.getRangeByName('R$excelRow').setText(data['Store Name']);
      i++;
      excelRow++;
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Report.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    print("Path:  $fileName");
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Successfully'),
              content: const Text('Report file successfully Created'),
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

  }


  Future<void> deleteAllDocuments() async {
    setState(() {
      showDialog(context: context, builder: (context){
        return Center(
          child: CircularProgressIndicator(),
        );
      });
    });
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection("Client").get();
    final List<Future<void>> futures = [];
    for (final DocumentSnapshot doc in snapshot.docs) {
      futures.add(doc.reference.delete());
    }
    Navigator.of(context).pop();
    await Future.wait(futures);
    setState(() {
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
          }
      );
    });
  }
}