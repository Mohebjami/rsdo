import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_platform/universal_platform.dart';

class Controller extends StatefulWidget {
  const Controller({super.key});

  @override
  State<Controller> createState() => _ControllerState();
}

List<List<dynamic>> data = [];

class _ControllerState extends State<Controller> {
  bool shouldAbsorb = false;
  bool isDeleted = false;
  late var text;
  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    var now = DateTime.now();
    setState(() {
      if (now.hour < 12) {
        text = 'Good Morning';
      } else {
        text = 'Good Afternoon';
      }
    });
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(45, 47, 98, 1),
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text("Admin", style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "BAHNSCHRIFT"),
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(45, 47, 98, 1),
                    radius: 30,
                    child: Image(image: AssetImage("assets/icon/Export.png"),height: 26,),
                  ),
                  title: const Text("Export Data",style: TextStyle(fontSize: 22, fontFamily: "ANTQUAB"),),
                  subtitle: const Text("Upload Data"),
                  onTap: ()async{
                    final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['csv']);
                    if (result != null) {
                      int counter = 0; // Initialize the counter
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
                            // 'Tazkira Number': row[10],
                            'Alternate Recipient': row[10],
                            'Account Number': row[11],
                            'Location': row[12],
                            'Address': row[13],
                            'province': row[14],
                            'District': row[15],
                            'Amount': row[16],
                            // Add more fields as needed
                          });
                          counter++; // Increment the counter after each insertion
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 200,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        const CircularProgressIndicator(
                                          color: Colors.white,
                                          backgroundColor: Colors.grey,
                                        ),
                                        Text(
                                          'Inserted: $counter',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ), // Display the counter
                                      ],
                                    ),
                                  );
                                });
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
                          content: const Text('There is some error'),
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
                ),
                const SizedBox(height: 30,),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(45, 47, 98, 1),
                    radius: 30,
                    child: Image(image: AssetImage("assets/icon/Import.png"),height: 26,),
                  ),
                  title: const Text("Import Data",style: TextStyle(fontSize: 22, fontFamily: "ANTQUAB"),),
                  subtitle: const Text("Download Paid Data"),
                  onTap: (){
                    createExcel();
                  },
                ),
                const SizedBox(height: 30,),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(45, 47, 98, 1),
                    radius: 30,
                    child: Image(image: AssetImage("assets/icon/SearchBeneficiaris.png"),height: 26,),
                  ),
                  title: const Text("Search Beneficiaries",style: TextStyle(fontSize: 22, fontFamily: "ANTQUAB"),),
                  subtitle: const Text("Search Beneficiaries For Paid"),
                  onTap: (){
                    Navigator.pushNamed(context, 'show');
                  },
                ),
                const SizedBox(height: 30,),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(45, 47, 98, 1),
                    radius: 30,
                    child: Image(image: AssetImage("assets/icon/AddDistributor.png"),height: 26,),
                  ),
                  title: const Text("Search Paid",style: TextStyle(fontSize: 22, fontFamily: "ANTQUAB"),),
                  subtitle: const Text("Search Paid"),
                  onTap: (){
                    Navigator.pushNamed(context, 'FetchPaidData');
                  },
                ),
                const SizedBox(height: 30,),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(45, 47, 98, 1),
                    radius: 30,
                    child: Image(image: AssetImage("assets/icon/Add admin.png"),height: 26,),
                  ),
                  title: const Text("Add Admin",style: TextStyle(fontSize: 22, fontFamily: "ANTQUAB"),),
                  subtitle: const Text("Add New Admin"),
                  onTap: (){
                    Navigator.pushNamed(context, 'admin');
                  },
                ),
                const SizedBox(height: 30,),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(45, 47, 98, 1),
                    radius: 30,
                    child: Image(image: AssetImage("assets/icon/AddDistributor.png"),height: 26,),
                  ),
                  title: const Text("Add Distributor",style: TextStyle(fontSize: 22, fontFamily: "ANTQUAB"),),
                  subtitle: const Text("Add New Distributor"),
                  onTap: (){
                    Navigator.pushNamed(context, 'Surveyor');
                  },
                ),
                const SizedBox(height: 30,),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(45, 47, 98, 1),
                    radius: 30,
                    child: Image(image: AssetImage("assets/icon/DeleteData.png"),height: 26,),
                  ),
                  title: const Text("Delete Data",style: TextStyle(fontSize: 22, fontFamily: "ANTQUAB"),),
                  subtitle: const Text("Delete All Data Data"),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete All Data', style: TextStyle(color: Colors.red)),
                          content: const Text('Are you sure you want to delete all data?'),
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
                  }
                ),
                const SizedBox(height: 30,),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(45, 47, 98, 1),
                    radius: 30,
                    child: Image(image: AssetImage("assets/icon/DeletePaid.png"),height: 26,),
                  ),
                  title: const Text("Delete Paid",style: TextStyle(fontSize: 22, fontFamily: "ANTQUAB"),),
                  subtitle: const Text("Delete All Paid Of Distributor"),
                  onTap: (){
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
                              child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      },
                    );
                  },
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
    sheet.getRangeByName('C1').setText('Household Name Code');
    sheet.getRangeByName('D1').setText('Recipient First Name');
    sheet.getRangeByName('E1').setText('Recipient Last Name');
    sheet.getRangeByName('F1').setText('Father Name');
    sheet.getRangeByName('G1').setText('Recipient Gender');
    sheet.getRangeByName('H1').setText('Recipient Document List');
    sheet.getRangeByName('I1').setText('Mobile Number');
    sheet.getRangeByName('J1').setText('Recipient Mobile Number');
    sheet.getRangeByName('K1').setText('Tazkira Number');
    sheet.getRangeByName('L1').setText('Alternate Recipient');
    sheet.getRangeByName('M1').setText('Account Number');
    sheet.getRangeByName('N1').setText('Location');
    sheet.getRangeByName('O1').setText('Address');
    sheet.getRangeByName('P1').setText('province');
    sheet.getRangeByName('Q1').setText('District');
    sheet.getRangeByName('R1').setText('Amount');
    sheet.getRangeByName('S1').setText('Store Name');
    sheet.getRangeByName('T1').setText('Current time');
    // sheet.getRangeByName('U1').setText('Cposition');
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
          .setText(data['Recipient Document List'].toString());
      sheet
          .getRangeByName('I$excelRow')
          .setText(data['Phone Number'].toString());
      sheet
          .getRangeByName('J$excelRow')
          .setText(data['Mobile Number'].toString());
      sheet
          .getRangeByName('K$excelRow')
          .setText(data['Tazkira Number'].toString());
      sheet.getRangeByName('L$excelRow').setText(data['Alternate Recipient']);
      sheet
          .getRangeByName('M$excelRow')
          .setText(data['Account Number'].toString());
      sheet.getRangeByName('N$excelRow').setText(data['Location']);
      sheet.getRangeByName('O$excelRow').setText(data['Address'].toString());
      sheet.getRangeByName('P$excelRow').setText(data['province']);
      sheet.getRangeByName('Q$excelRow').setText(data['District']);
      sheet.getRangeByName('R$excelRow').setText(data['Amount'].toString());
      sheet.getRangeByName('S$excelRow').setText(data['Store Name']);
      sheet.getRangeByName('T$excelRow').setText(data['Current time']);
      // sheet.getRangeByName('U$excelRow').setText(data['Cposition']);
      i++;
      excelRow++;
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (UniversalPlatform.isAndroid) {
      var path = await AndroidPathProvider.downloadsPath;
      final String fileName = '$path/Report.xlsx';
      final File file = File(fileName);
      await file
          .writeAsBytes(bytes, flush: true)
          .then((_) => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Successfully'),
                  content: const Text("Report file successfully created"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        print("Done");
                      },
                    ),
                  ],
                );
              }))
          .catchError((error) => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Failed'),
                  content: Text("$error"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }));
    } else if (kIsWeb) {
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "Report.xlsx")
        ..click();
      html.Url.revokeObjectUrl(url);
    }
  }

  // Define a boolean variable to control the state of the loading indicator
  bool _isLoading = false;

  Future<void> deleteAllDocuments() async {
    // Set _isLoading to true when the deletion process starts
    setState(() {
      _isLoading = true;
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
              // Set _isLoading to false when the deletion process ends
              _isLoading = false;

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
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }))
        .catchError((error) => setState(() {
              // Set _isLoading to false when an error occurs
              _isLoading = false;

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

    FirebaseFirestore.instance.collection('Paid').get().then((snapshot) {
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
