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
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                "Search Paid",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "BAHNSCHRIFT"),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(45, 47, 98, 1),
            foregroundColor: Colors.white,
          ),
        ),
        body: Container(
          width: fullScreenWidth,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/searchback.png"),fit: BoxFit.cover)
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: TextField(
                    controller: _textController,
                    style: const TextStyle(color: Color.fromRGBO(47, 47, 94, 1),),
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(196, 214, 230, 1),
                      filled: true,
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Color.fromRGBO(47, 47, 94, 1),),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _search,
                        icon: const Icon(Icons.search,color: Color.fromRGBO(47, 47, 94, 1),),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 360,
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
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Failed to add document'),
                                                backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                                                showCloseIcon: true,
                                                duration: Duration(seconds: 2),
                                              ));
                                            }
                                          })
                                    ]),
                                child:Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(196, 214, 230, 1),
                                    border: Border.all(
                                      color:
                                      const Color.fromRGBO(196, 214, 230, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      data['Recipient Name'],
                                      style: const TextStyle(
                                          color: Color.fromRGBO(47, 47, 94, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data['Alternate Recipient'],
                                      style: const TextStyle(
                                        color: Color.fromRGBO(47, 47, 94, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Text(data['S/N'].toString(),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(47, 47, 94, 1),
                                          fontSize: 20),),
                                    trailing: Text(data['Account Number'].toString().substring(data['Account Number'].toString().length - 5),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(47, 47, 94, 1),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

