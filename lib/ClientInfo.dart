import 'package:flutter/material.dart';

class ClientInfo extends StatelessWidget {
  final Map data;

  const ClientInfo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double fullScreenHeight = MediaQuery.of(context).size.height;
    double fullScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text("Beneficiaries Information", style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "BAHNSCHRIFT"),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
              Container(
                width: 300,
                height: 80,
                decoration: const BoxDecoration(
                  color:  Color.fromRGBO(252,163,19,1),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Center(child: Text('${data['Recipient Name']} ${data['Recipient Last Name']}',style: const TextStyle(color: Colors.white, fontSize: 23,fontFamily: 'LilitaOne'),)),
              ),
            const SizedBox(
                height: 30,
              ),
            Stack(
              children: [
               Center(
                 child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromRGBO(125, 178, 220, 1),),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Center(child: Text('Father Name',style: TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 20,fontFamily: 'LilitaOne'),)),
                               ),
               ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Center(
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: const BoxDecoration(
                        color:  Color.fromRGBO(125, 178, 220, 1),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Center(child: Text('${data['Father Name']}',style: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 18,),)),
                    ),
                  ),
                ),
             ]
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromRGBO(125, 178, 220, 1),),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(child: Text('Recipient Mobile Number',style: TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 35,
                        decoration: const BoxDecoration(
                          color:  Color.fromRGBO(125, 178, 220, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(child: Text('${data['Mobile Number']}',style: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                      ),
                    ),
                  ),
                ]
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromRGBO(125, 178, 220, 1),),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(child: Text('Household Name Code',style: TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: const BoxDecoration(
                          color:  Color.fromRGBO(125, 178, 220, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(child: Text('${data['Household Name Code']}',style: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,),)),
                            ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromRGBO(125, 178, 220, 1),),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(child: Text('Alternate Recipient',style: TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: const BoxDecoration(
                          color:  Color.fromRGBO(125, 178, 220, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(child: Text('${data['Alternate Recipient'] == null || data['Alternate Recipient'] == '' ? 'It does not alternate' : data['Alternate Recipient']}',style: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                      ),
                    ),
                  ),
                ]
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromRGBO(125, 178, 220, 1),),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(child: Text('Account Number',style: TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: const BoxDecoration(
                          color:  Color.fromRGBO(125, 178, 220, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(child: Text('${data['Account Number']}',style: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                      ),
                    ),
                  ),
                ]
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromRGBO(125, 178, 220, 1),),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(child: Text('Household ID',style: TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: const BoxDecoration(
                          color:  Color.fromRGBO(125, 178, 220, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(child: Text('${data['Household ID']}',style: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                      ),
                    ),
                  ),
                ]
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
                children: [
                  Center(
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromRGBO(125, 178, 220, 1),),
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: const Center(child: Text('Recipient Document List',style: TextStyle(color: Color.fromRGBO(45, 47, 98, 1), fontSize: 23,fontFamily: 'LilitaOne'),)),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Center(
                        child: Container(
                          width: 300,
                          height: 100,
                          decoration: const BoxDecoration(
                            color:  Color.fromRGBO(125, 178, 220, 1),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(child: Text(data['Recipient Document List'].toString().replaceAll(',', '\n'),style: const TextStyle(color: Color.fromRGBO(45, 47, 98, 1),),)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
