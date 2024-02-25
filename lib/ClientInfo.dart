import 'package:flutter/material.dart';

class ClientInfo extends StatelessWidget {
  final Map data;

  const ClientInfo({Key? key, required this.data}) : super(key: key);

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
                radius:70,
                child: Text('${data['Recipient Name']}',),
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(border: Border.all(width: 0.5 ,color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SN: ${data['SN']}'),

                    const SizedBox(height: 5,),
                    Text('Father Name: ${data['Father Name']}'),
                    const SizedBox(height: 5,),
                    Text('Recipient Document List: ${data['Recipient Document List']}'),
                    const SizedBox(height: 5,),
                    Text('Account Number: ${data['Account Number']}'),
                    const SizedBox(height: 5,),
                    Text('Household Name Code: ${data['Household Name Code']}'),
                    const SizedBox(height: 5,),
                    Text('Alternate Recipient: ${data['Alternate Recipient']}'),
                    const SizedBox(height: 5,),
                    Text('Mobile Number: ${data['Mobile Number']}'),
                    const SizedBox(height: 5,),
                    Text('Tazkira Number: ${data['Tazkira Number']}'),
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
