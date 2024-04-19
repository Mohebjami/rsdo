import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rsdo/ClientInfo.dart';
import 'package:rsdo/WelcomePage.dart';

class FetchData extends StatefulWidget {
  final data;
  const FetchData({super.key, required this.data});
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController SM_Name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  String dropdownValue = 'Household Name Code';
  List<String> _superMarketNames = ['Market 1', 'Market 2', 'Market 3']; // Add your market names here
  String? _selectedMarket;


  String _searchText = '';

  late var data;

  void _search() {
    setState(() {
      _searchText = _textController.text;
    });
  }

  bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    double fullScreenHeight = MediaQuery.of(context).size.height;
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text("Search Beneficiaries", style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "BAHNSCHRIFT"),
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
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection('Paid').where('Store Name', isEqualTo: '${widget.data}').snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text("Loading");
                                        }
                                        int? docLength = snapshot.data?.docs
                                            .length; // Assigning length to a variable
                                        // Printing the length
                                        return Countup(
                                          begin: 0,
                                          end: docLength?.toDouble() ?? 0,
                                          duration:
                                          const Duration(seconds: 2),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 25),
                                        );
                                      },
                                    ),
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection('Paid').where('Store Name', isEqualTo: '${widget.data}') // Replace 'Your Store Name' with the actual store name
                                          .where('Recipient Gender',
                                          isEqualTo: 'Female')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text("Loading");
                                        }
                                        int? docLength = snapshot.data?.docs.length; // Assigning length to a variable
                                        // Printing the length
                                        return Countup(
                                          begin: 0,
                                          end: docLength?.toDouble() ?? 0,
                                          duration: const Duration(seconds: 2),
                                          style: const TextStyle(color: Colors.black, fontSize: 25),
                                        );
                                      },
                                    ),
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection('Paid').where('Store Name', isEqualTo: '${widget.data}') // Replace 'Your Store Name' with the actual store name
                                          .where('Recipient Gender', isEqualTo: 'Male').snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text("Loading");
                                        }
                                        int? docLength = snapshot.data?.docs
                                            .length; // Assigning length to a variable
                                        // Printing the length
                                        return Countup(
                                          begin: 0,
                                          end: docLength?.toDouble() ?? 0,
                                          duration:
                                          const Duration(seconds: 2),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 25),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Total "),
                                  Text("Female"),
                                  Text("Male  "),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Icon(
                    Icons.insert_chart_outlined_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/searchback.png"),fit: BoxFit.cover)
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(196, 214, 230, 1),
                      borderRadius: BorderRadius.circular(51.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0, top: 5.0),
                    child: DropdownButton<String>(
                      padding: const EdgeInsets.only(left: 8.0),
                      value: dropdownValue,
                      focusColor: const Color.fromRGBO(45, 47, 98, 1),
                      iconEnabledColor: const Color.fromRGBO(45, 47, 98, 1),
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1),fontWeight: FontWeight.bold), // Change color here
                      dropdownColor: const Color.fromRGBO(196, 214, 230, 1),
                      underline: Container(color: Colors.transparent,),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Household Name Code', 'Account Number']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _textController,
                    style: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1),),
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(196, 214, 230, 1),
                      hintText:  "Search",
                      hintStyle: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1),),
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _search,
                        icon: const Icon(
                          Icons.search,
                          color: Color.fromRGBO(45, 47, 98, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('Clients')
                      .where(dropdownValue,
                          isEqualTo: dropdownValue == 'Account Number' &&
                                  isNumeric(_searchText)
                              ? int.parse(_searchText)
                              : _searchText)
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
                        var ss = "${widget.data}";
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
                                        borderRadius: BorderRadius.circular(15),
                                        backgroundColor: const Color.fromRGBO(45, 47, 98, 1),
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
                                                'Recipient Gender':
                                                    recipientGender,
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
                                                _handlePaymentSuccess();
                                              }).catchError((error) {
                                                if (mounted) {
                                                  // Check if the widget is still in the tree
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text("$error"),
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            47, 47, 94, 1),
                                                    showCloseIcon: true,
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  ));
                                                }
                                              });
                                            } else {
                                              _handlePayment();
                                            }
                                          } catch (e) {
                                            print('Failed to add document: $e');
                                          }
                                        })
                                  ]),
                              child: Center(
                                child: Container(
                                  width: 350,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(196, 214, 230, 1),
                                    border: Border.all(
                                      color: const Color.fromRGBO(196, 214, 230, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      data['Recipient Name'],
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 47, 98, 1),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data['Alternate Recipient'],
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 47, 98, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Text(
                                      data['SN'].toString(),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(45, 47, 98, 1), fontSize: 20),
                                    ),
                                    trailing: Text(
                                      data['Account Number'].toString().substring(
                                          data['Account Number'].toString().length -
                                              5),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(45, 47, 98, 1), fontSize: 15),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ClientInfo(data: data),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
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
      ),
    );
  }
  void _showDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("assets/AlreadPaid.JPG"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.orangeAccent.withOpacity(0.6), // this is a common warning color
                        BlendMode.srcOver,
                      ),
                    )
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.white, size: 100),
                    SizedBox(
                      height: 50,
                    ),
                    Text('Already Paid', style: TextStyle(color: Colors.white, fontSize: 30,fontFamily: "LilitaOne")),
                  ],
                ),
              ),
              Container(
                width: 350,
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Text('Beneficiaries were paid.', style: TextStyle(fontSize: 20,fontFamily: "LilitaOne")),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                        ),
                        child: const Text('CONTINUE', style: TextStyle(color: Colors.white,fontFamily: "LilitaOne")),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handlePayment() async {
    try {
      _showDialog(context); // Use the captured context here
    } catch (error) {
      print('Failed to add document: $error');
    }
  }


  void _showDialogSuccess(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 350,
                width: 350,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/seccsess.JPG"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color.fromRGBO(34, 177, 76, 0.6),
                        BlendMode.srcOver,
                      ),
                    )
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.white, size: 100),
                    SizedBox(
                      height: 50,
                    ),
                    Text('SUCCESS', style: TextStyle(color: Colors.white, fontSize: 30)),
                  ],
                ),
              ),
              Container(
                width: 350,
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text('Successful Paid.', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[800],
                      ),
                      child: const Text('CONTINUE', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handlePaymentSuccess() async {
    try {
      _showDialogSuccess(context); // Use the captured context here
    } catch (error) {
      print('Failed to add document: $error');
    }
  }
}
