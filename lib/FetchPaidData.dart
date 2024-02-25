import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FetchPadiData extends StatelessWidget {
  const FetchPadiData({super.key});

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
          title: const Text('Paid'),
          backgroundColor: const Color.fromRGBO(47, 47, 97, 1),
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
                stream: _firestore.collection('Paid').where('Household Name Code', isEqualTo: _searchText).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Text('Empty');
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      var householdId = data['Household ID'];
                      if(data.isEmpty){
                        print("object");
                        return const Text('Something went wrong');
                      }
                      return Slidable(
                        closeOnScroll: true,
                        startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                  backgroundColor: Colors.red,
                                  icon: Icons.check,
                                  label: 'Delete',
                                  onPressed: (context) async {
                                    try {
                                      var querySnapshot = await FirebaseFirestore.instance.collection('Paid').where('Household ID', isEqualTo: householdId).get();
                                      querySnapshot.docs.forEach((doc) async {
                                        await FirebaseFirestore.instance.collection('Paid').doc(doc.id).delete();
                                      });
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
                          leading: Text(data['S/N'].toString()),
                        ),
                      );
                    }
                    ).toList(),
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

