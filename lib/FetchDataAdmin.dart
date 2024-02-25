import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rsdo/ClientInfo.dart';

class FetchDataAdmin extends StatelessWidget {
  const FetchDataAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return const FirebaseListView();
  }
}

class FirebaseListView extends StatefulWidget {
  const FirebaseListView({super.key});

  @override
  _FirebaseListViewState createState() => _FirebaseListViewState();
}

class _FirebaseListViewState extends State<FirebaseListView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  String _searchText = '';
  late var data;

  void _search() {
    setState(() {
      _searchText = _textController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Clients'),
          backgroundColor: const Color.fromRGBO(47, 47, 97, 1),
          actions: [
            // set a Icon image of statistics and firlter by name
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: "Search",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: _search,
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('Clients')
                    .where('Household Name Code', isEqualTo: _searchText)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      CollectionReference paid =
                          FirebaseFirestore.instance.collection('Paid');
                      var sn = data['SN'];
                      var householdId = data['Household ID'];
                      var householdNameCode = data['Household Name Code'];
                      var recipientName = data['Recipient Name'];
                      var recipientLastName = data['Recipient Last Name'];
                      var fatherName = data['Father Name'];
                      var recipientGender = data['Recipient Gender'];
                      var recipientDocumentList =
                          data['Recipient Document List'];
                      var phoneNumber = data['Phone Number'];
                      var mobileNumber = data['Mobile Number'];
                      var tazkiraNumber = data['Tazkira Number'];
                      var alternateRecipient = data['Alternate Recipient'];
                      var accountNumber = data['Account Number'];
                      var Location = data['Location'];
                      var Address = data['Address'];
                      var province = data['province'];
                      var District = data['District'];
                      var Amount = data['Amount'];
                      var ss = "Paid with Admin";
                      return Slidable(
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
// Check if the data already exists in the 'Paid' collection
                                      var querySnapshot =
                                          await FirebaseFirestore.instance
                                              .collection('Paid')
                                              .where('Household ID',
                                                  isEqualTo: householdId)
                                              .get();

// If the data does not exist, add it to the 'Paid' collection
                                      if (querySnapshot.docs.isEmpty) {
                                        await paid.add({
                                          'S/N': sn,
                                          'Household ID': householdId,
                                          'Household Name Code':
                                              householdNameCode,
                                          'Recipient Name': recipientName,
                                          'Recipient Last Name':
                                              recipientLastName,
                                          'Father Name': fatherName,
                                          'Recipient Gender': recipientGender,
                                          'Recipient Document List':
                                              recipientDocumentList,
                                          'Phone Number': phoneNumber,
                                          'Mobile Number': mobileNumber,
                                          'Tazkira Number': tazkiraNumber,
                                          'Alternate Recipient':
                                              alternateRecipient,
                                          'Account Number': accountNumber,
                                          'Location': Location,
                                          'Address': Address,
                                          'province': province,
                                          'District': District,
                                          'Amount': Amount,
                                          'Store Name': ss,
                                        }).then((value) {
                                          print("Record added to Firestore");
                                          _scaffoldMessengerKey.currentState
                                              ?.showSnackBar(SnackBar(
                                            content: Container(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              height: 90,
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                "Successfully Paid",
                                                style: TextStyle(fontSize: 20),
                                              )),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            elevation: 0.0,
                                            duration:
                                                const Duration(seconds: 2),
                                            behavior: SnackBarBehavior.floating,
                                          ));
                                        }).catchError((error) {
                                          print("Failed to add record: $error");
                                          if (mounted) {
// Check if the widget is still in the tree
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("$error"),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      47, 47, 94, 1),
                                              showCloseIcon: true,
                                              duration:
                                                  const Duration(seconds: 2),
                                            ));
                                          }
                                        });
                                      } else {
                                        _scaffoldMessengerKey.currentState
                                            ?.showSnackBar(SnackBar(
                                          content: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            height: 90,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: const Center(
                                                child: Text(
                                              "Duplicate data",
                                              style: TextStyle(fontSize: 20),
                                            )),
                                          ),
                                          backgroundColor: Colors.transparent,
                                          elevation: 0.0,
                                          duration: const Duration(seconds: 2),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      }
                                    } catch (e) {
                                      print('Failed to add document: $e');
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
                          leading: Text(data['SN'].toString()),
                          trailing: Text(data['Account Number'].toString()),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClientInfo(data: data),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
