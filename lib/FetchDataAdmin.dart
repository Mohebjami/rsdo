import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FetchDataAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirebaseListView();

  }
}

class FirebaseListView extends StatefulWidget {
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
                      var Household_ID = data['Household ID'];
                      var Household_Name_Code = data['Household Name Code'];
                      var Recipient_Name = data['Recipient Name'];
                      var Recipient_Last_Name = data['Recipient Last Name'];
                      var Father_Name = data['Father Name'];
                      var Recipient_Gender = data['Recipient Gender'];
                      var Recipient_Document_List =
                          data['Recipient Document List'];
                      var Phone_Number = data['Phone Number'];
                      var Mobile_Number = data['Mobile Number'];
                      var Account_Number = data['Account Number'];
                      var Alternate_Recipient = data['Alternate Recipient'];
                      var Address = data['Address'];
                      var Region = data['Region'];
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
                                      var querySnapshot = await FirebaseFirestore.instance.collection('Paid').where('Household ID', isEqualTo: Household_ID).get();

// If the data does not exist, add it to the 'Paid' collection
                                      if (querySnapshot.docs.isEmpty) {
                                        await paid.add({
                                          'S/N': sn,
                                          'Household ID': Household_ID,
                                          'Household Name Code':
                                              Household_Name_Code,
                                          'Recipient Name': Recipient_Name,
                                          'Recipient Last Name':
                                              Recipient_Last_Name,
                                          'Father Name': Father_Name,
                                          'Recipient Gender': Recipient_Gender,
                                          'Recipient Document List':
                                              Recipient_Document_List,
                                          'Phone Number': Phone_Number,
                                          'Mobile Number': Mobile_Number,
                                          'Account Number': Account_Number,
                                          'Alternate Recipient':
                                              Alternate_Recipient,
                                          'Address': Address,
                                          'Region': Region,
                                          'province': province,
                                          'District': District,
                                          'Amount': Amount,
                                          'Store Name': ss,
                                        }).then((value) {
                                          print("Record added to Firestore");
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
                                                "Successfully Paid",
                                                style: TextStyle(fontSize: 20),
                                              )),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            elevation: 0.0,
                                            duration: const Duration(seconds: 2),
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
                                        print("Duplicate data");
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
                                    print("3");
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
