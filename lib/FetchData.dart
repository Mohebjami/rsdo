import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:download/download.dart';
import 'package:flutter/foundation.dart';
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
  late var client, id, clients, data;
  var name = "";


  void ShowForm() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromRGBO(47, 47, 94, 1),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Done"),
              )),
        );
      },
    );
  }
  int i =0;
  @override
  Widget build(BuildContext context) {
    double fullScreenHeight = MediaQuery.of(context).size.height;
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: [
          IconButton(onPressed: (){
            downloadCollectionAsCsv();
          }, icon: Icon(Icons.download_for_offline))
        ],
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
                              i++;
                              if (name.isEmpty) {
                                return ListTile(
                                  title: Text(
                                    data['Recipient Name'],
                                  ),
                                  subtitle: Text(
                                    data['Father Name'],
                                  ),
                                  leading: Text("$i"),
                                );
                              }
                              if (data['Recipient Name'].toString().toLowerCase().startsWith(name.toLowerCase()) || data['Mobile Number'].toString().toLowerCase().startsWith(name.toLowerCase())) {
                                return Slidable(
                                  closeOnScroll: true,
                                  startActionPane: ActionPane(motion: const StretchMotion(),
                                      children:[
                                        SlidableAction(
                                          backgroundColor: Colors.red,
                                          icon: Icons.check,
                                          label: 'Paid',
                                          onPressed: (context) {
                                            try {
                                              final CollectionReference client = FirebaseFirestore.instance.collection("Paid");
                                              for (var i = 0;
                                              i < data.length;
                                              i++) {
                                                var record = {
                                                  'S/N': data['S/N'],
                                                  'Household ID': data['Household ID'],
                                                  'Household Name/Code': data['Household Name/Code'],
                                                  'Recipient Name': data['Recipient Name'],
                                                  'Father Name': data['Father Name'],
                                                  'Recipient Gender':data['Recipient Gender'],
                                                  'Document number':data['Document number'],
                                                  'Alternate Recipient': data['Alternate Recipient'],
                                                  'Account Number': data['Account Number'],
                                                  'Household Size': data['Household Size'],
                                                  'Phone Number': data['Phone Number'],
                                                  'Mobile Number': data['Mobile Number'],
                                                  'Location': data['Location'],
                                                  'Address': data['Address'],
                                                  'District': data['District'],
                                                  'province': data['province'],
                                                  'Amount': data['Amount'],
                                                  'Store Name': data['Store Name'],
                                                };
                                                client.add(record);
                                                print("$i Paid");
                                              }
                                            } catch (err) {
                                              print(err);
                                            }
                                          },
                                        )
                                      ]
                                  ),
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
      floatingActionButton: ElevatedButton(
        onPressed: () {
          for (client in clients!) {
            id = client.id;
            _documentReference =
                FirebaseFirestore.instance.collection('Client').doc(id);
            _documentReference.delete();
          }
        },
        child: Text("delete"),
      ),
    );
  }
  Future downloadCollectionAsCsv() async {
   var docs = [];
    String fileContent =
        "Household_ID,Household_Name_Code,Recipient_Name,Father_Name,Recipient_Gender,Document_number,Alternate_Recipient,Account_Number,Household_Size,Phone_Number,Mobile_Number,Location,Address,District,province,Amount,Store_Name";
    docs.asMap().forEach((index, record) => fileContent =
        fileContent +
            "\n" +
            record.SN.toString() +
            "," +
            record.Household_ID.toString() +
            "," +
            record.Household_Name_Code.toString() +
            "," +
            record.Recipient_Name.toString() +
            "," +
            record.Father_Name.toString() +
            "," +
            record.Recipient_Gender.toString() +
            "," +
            record.Document_number.toString() +
            "," +
            record.Alternate_Recipient.toString() +
            "," +
            record.Account_Number.toString() +
            "," +
            record.Household_Size.toString() +
            "," +
            record.Phone_Number.toString() +
            "," +
            record.Mobile_Number.toString() +
            "," +
            record.Location.toString() +
            "," +
            record.Address.toString() +
            "," +
            record.District.toString() +
            "," +
            record.province.toString() +
            "," +
            record.Amount.toString() +
            "," +
            record.Store_Name.toString());


    final fileName = "res.csv";

    var bytes = utf8.encode(fileName);

    final stream = Stream.fromIterable(bytes);

    return download(stream, fileName);

  }
}
