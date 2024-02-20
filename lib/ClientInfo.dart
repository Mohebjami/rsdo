import 'package:flutter/material.dart';

class ClientInfo extends StatelessWidget {
  final Map data;

  ClientInfo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                child: Text('${data['Recipient Name']}',),
                radius:70,
              ),
            ),
            SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(border: Border.all(width: 0.5 ,color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SN: ${data['SN']}'),

                    SizedBox(height: 5,),
                    Text('Father Name: ${data['Father Name']}'),
                    SizedBox(height: 5,),
                    Text('Recipient Document List: ${data['Recipient Document List']}'),
                    SizedBox(height: 5,),
                    Text('Account Number: ${data['Account Number']}'),
                    SizedBox(height: 5,),
                    Text('Household Name Code: ${data['Household Name Code']}'),
                    SizedBox(height: 5,),
                    Text('Alternate Recipient: ${data['Alternate Recipient']}'),
                    SizedBox(height: 5,),
                    Text('Mobile Number: ${data['Mobile Number']}'),
                  ],
                ),
              ),
            ),

            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
