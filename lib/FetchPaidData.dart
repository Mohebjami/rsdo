import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rsdo/ClientInfo.dart';

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
          backgroundColor: const Color.fromRGBO(70, 130, 180, 1),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: const Color.fromRGBO(70, 130, 180, 0.9),
                  filled: true,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none,
                  ),



                  suffixIcon: IconButton(
                    onPressed: _search,
                    icon: const Icon(Icons.search,color: Colors.white,),
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Slidable(
                            closeOnScroll: true,
                            startActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete_forever,
                                      borderRadius: BorderRadius.circular(15),
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
                            child:Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(70, 130, 180, 0.9),
                                border: Border.all(
                                  color:
                                  const Color.fromRGBO(70, 130, 180, 0.9),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                title: Text(
                                  data['Recipient Name'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  data['Alternate Recipient'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: Text(data['S/N'].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20),),
                                trailing: Text(data['Account Number'].toString().substring(data['Account Number'].toString().length - 5),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15),),
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClientInfo(data: data),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
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

