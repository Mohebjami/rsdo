import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rsdo/Controller.dart';
import 'package:rsdo/FetchData.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Chats Page'),
    Text('Status Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController emailD = TextEditingController();
  TextEditingController passwordD = TextEditingController();
  List<String> _superMarketNames = [
    'Arg',
    'Zaitoon',
    'Rafa',
    'Sohail',
    'Safa',
    'Mohandes Zada',
    'Popal',
    'Almas',
    'Arzan Qimat',
    'Roze-Herat',
    'Siyawshani',
    'Ansar',
    'Amini',
    'Anjeer',
    'Salar',
    'Korosh'
  ]; // Add your market names here
  String? _selectedMarket;
  late var test_data;
  bool hasInternet = false;
  bool isCorrect = false;
  int press = 0;

  @override
  Widget build(BuildContext context) {
    double fullScreenHeight = MediaQuery.of(context).size.height;
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: const Color.fromRGBO(45, 47, 98, 1),
            title: const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                "Value Voucher",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "BAHNSCHRIFT"),
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
        body: Container(
          height: fullScreenHeight,
          width: fullScreenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(_selectedIndex == 0 ? "assets/AdminLogin.png" : "assets/project.jpg"),
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: BottomNavigationBar(
                  backgroundColor: const Color.fromRGBO(45, 47, 98, 1),
                  unselectedItemColor: Colors.grey,
                  selectedIconTheme: const IconThemeData(size: 28),
                  selectedItemColor: const Color.fromRGBO(252, 163, 19, 1),
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.admin_panel_settings),
                      label: 'Admin',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Distributor',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
              ),
              Expanded(
                child:
                    _selectedIndex == 0 ? adminLoginTest() : distributorTest(),
              ),
            ],
          ),
        ));
  }

  Widget adminLoginTest() {
    String myEmail = "moheb@moheb.com";
    String pass = "1moheb@296";
    late var test_data;
    bool hasInternet = false;
    bool isCorrect = false;
    int press = 0;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Admin Login",
                        style: TextStyle(
                            fontFamily: "LilitaOne",
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 280,
                height: 40,
                child: TextField(
                  controller: email,
                  style:
                      const TextStyle(color: Color.fromRGBO(44, 62, 82, 1)),
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(195, 214, 230, 1),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color.fromRGBO(44, 62, 82, 1),
                    ),
                    hintText: 'User Name',
                    hintStyle:
                        const TextStyle(color: Color.fromRGBO(44, 62, 82, 1)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 280,
                height: 40,
                child: TextField(
                  controller: password,
                  style:
                      const TextStyle(color: Color.fromRGBO(44, 62, 82, 1)),
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(195, 214, 230, 1),
                      filled: true,
                      hintText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock_rounded,
                        color: Color.fromRGBO(44, 62, 82, 1),
                      ),
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(44, 62, 82, 1)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 305,
                  height: 40,
                  child: MaterialButton(
                    textColor: Colors.white,
                    onPressed: () async {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: LoadingAnimationWidget.newtonCradle(
                                  color: Colors.white,
                                  size: 100,
                                ),
                              );
                            });
                      });
                      // Your existing code here...
                      // Navigator.of(context).pop();
                      var data;
                      int i = 0;
                      press++;
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: LoadingAnimationWidget.newtonCradle(
                                  color: Colors.white,
                                  size: 100,
                                ),
                              );
                            });
                      });
                      final QuerySnapshot snapshot = await FirebaseFirestore
                          .instance
                          .collection('Accounts')
                          .get();
                      Navigator.of(context).pop();
                      while (i < snapshot.docs.length) {
                        data =
                            snapshot.docs[i].data() as Map<String, dynamic>;
                        if (data['Email'] == email.text &&
                            data['Password'] == password.text) {
                          setState(() {
                            isCorrect = true;
                          });
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const Controller()),
                          );
                        }
                        i++;
                      }
                      if (isCorrect == false) {
                        setState(() {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Your username or password wrong'),
                            backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                            showCloseIcon: true,
                            duration: Duration(seconds: 3),
                          ));
                        });
                      }
                      if (press > 3) {
                        press = 0;
                        setState(() {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'If you forget you Email or password connect to admin'),
                            backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                            showCloseIcon: true,
                            duration: Duration(seconds: 2),
                          ));
                        });
                      }
                      email.clear();
                      password.clear();
                    },
                    child: Ink(
                      width: 300,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(45, 47, 98, 1),
                            Color.fromRGBO(77, 134, 193, 1),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                            'LOGIN', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),), // Replace 'Button' with your button label
                      ),
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget distributorTest() {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    void updateSurveyor(String surveyorValue, String newData) async {
      try {
        await _firestore.collection('Surveyor').where('NSuperMarket', isEqualTo: surveyorValue).get().then((querySnapshot) {
          querySnapshot.docs.forEach((document) {
            document.reference.update({'NSuperMarket': newData});
          });
        });
      } catch (e) {
        print(e);
      }
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Distributor Login",
                              style: TextStyle(
                                  fontFamily: "LilitaOne",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 280,
                      height: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(195, 214, 230, 1),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 5.0, top: 5.0),
                        child: DropdownButton<String>(
                          value: _selectedMarket,
                          hint: const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:  Row(
                              children: [
                                Image(image: AssetImage("assets/17.png"),height: 30,),
                                Text(
                                  "  Please select a super market",
                                  style: TextStyle(color: Color.fromRGBO(44, 62, 82, 1)),
                                ),
                              ],
                            ),
                          ),

                          focusColor: Colors.white,
                          iconEnabledColor: Colors.white,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down,color: const Color.fromRGBO(44, 62, 82, 1),),
                          iconSize: 30,
                          elevation: 16,
                          style: const TextStyle(color: Color.fromRGBO(44, 62, 82, 1)),
                          dropdownColor: const Color.fromRGBO(195, 214, 230, 1),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedMarket = newValue;
                            });
                          },
                          items: _superMarketNames
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 280,
                      height: 40,
                      child: TextField(
                        controller: emailD,
                        style:
                            const TextStyle(color: Color.fromRGBO(44, 62, 82, 1)),
                        decoration: InputDecoration(
                          fillColor: const Color.fromRGBO(195, 214, 230, 1),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color.fromRGBO(44, 62, 82, 1),
                          ),
                          hintText: 'User Name',
                          hintStyle:
                              const TextStyle(color: Color.fromRGBO(44, 62, 82, 1)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 280,
                      height: 40,
                      child: TextField(
                          controller: passwordD,
                          style:
                              const TextStyle(color: Color.fromRGBO(44, 62, 82, 1)),
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: const Color.fromRGBO(195, 214, 230, 1),
                              filled: true,
                              hintText: 'Password',
                              prefixIcon: const Icon(
                                Icons.lock_rounded,
                                color: Color.fromRGBO(44, 62, 82, 1),
                              ),
                              hintStyle: const TextStyle(
                                  color: Color.fromRGBO(44, 62, 82, 1)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 305,
                      height: 40,
                      child: MaterialButton(
                        textColor: Colors.white,
                        onPressed: () async {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: LoadingAnimationWidget.newtonCradle(
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                  );
                                });
                          });
                          Navigator.of(context).pop();
                          //if (hasInternet) {
                          var data;
                          int i = 0;
                          press++;
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: LoadingAnimationWidget.newtonCradle(
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                  );
                                });
                          });
                          final QuerySnapshot snapshot = await FirebaseFirestore
                              .instance
                              .collection('Surveyor')
                              .get();
                          Navigator.of(context).pop();
                          while (i < snapshot.docs.length) {
                            data = snapshot.docs[i].data() as Map<String, dynamic>;
                            if (data['DistributorName'] == emailD.text &&
                                data['Password'] == passwordD.text) {
                              // Update 'NSuperMarket' with the selected market from the dropdown
                              await FirebaseFirestore.instance
                                  .collection('Surveyor')
                                  .doc(snapshot.docs[i].id)
                                  .update({
                                'NSuperMarket': _selectedMarket,
                              });
                              setState(() {
                                isCorrect = true;
                                test_data = data['NSuperMarket'];
                              });
                              // Check if _selectedMarket is not null before navigating
                              if (_selectedMarket != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FetchData(data: _selectedMarket),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Please select a Super Market")));
                              }
                            }
                            i++;
                          }

                          emailD.clear();
                          password.clear();

                          if (isCorrect == false) {
                            setState(() {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Your username or password wrong'),
                                backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                                showCloseIcon: true,
                                duration: Duration(seconds: 2),
                              ));
                            });
                          }
                          if (press > 3) {
                            press = 0;
                            setState(() {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'If you forget you Email or password connect to admin'),
                                backgroundColor: Color.fromRGBO(47, 47, 94, 1),
                                showCloseIcon: true,
                                duration: Duration(seconds: 2),
                              ));
                            });
                          }
                        },
                        child: Ink(
                          width: 280,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(45, 47, 98, 1),
                                Color.fromRGBO(77, 134, 193, 1),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                                'LOGIN'), // Replace 'Button' with your button label
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
