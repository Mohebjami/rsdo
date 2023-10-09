import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FetchPadiData extends StatefulWidget {
  const FetchPadiData({super.key});

  @override
  State<FetchPadiData> createState() => _FetchPadiDataState();
}



class _FetchPadiDataState extends State<FetchPadiData> {
  late var client, id, clients, data, data2;
  bool isPaid = true;
  var name = "";
  @override
  Widget build(BuildContext context) {
    double fullScreenHeight = MediaQuery.of(context).size.height;
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Paid"),
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
              FirebaseFirestore.instance.collection('Paid').snapshots(),

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
                          return ListTile(
                            title: Text(
                              data['Recipient Name'],
                            ),
                            subtitle: Text(
                              data['Father Name'],
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
    );
  }
}


