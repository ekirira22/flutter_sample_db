import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Inserting Data into a Database')),
        body: Center(
          child: TransferData(),
        ),
      ),
    );
  }
}

class TransferData extends StatefulWidget {

  _TransferDataState createState() => _TransferDataState();
}

class _TransferDataState extends State {

      //getting values from TextField Widget
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();

    //boolean variable for CircularProgressIndicator to show and hide the Circular progress indicator widget.
    bool visible = false;

    // Create a function named as webCall() in TransfterDataWidget class. In this class we would send the text input data to online server.
    // In this function we would first get the values from TextField widget and showing a Alert dialog message after successfully done the API web call.

   Future webCall() async{
     // Showing CircularProgressIndicator using State.
     setState((){
       visible = true;
     });

     //getting values from containers
     String name = nameController.text;
     String email = emailController.text;
     String phoneNumber = phoneNumberController.text;

    final response = await http.post('http://10.0.2.2/submit_data.php',
      body: {
        'name': nameController.text,
        'email': emailController.text,
        'phone_number': phoneNumberController.text,
      }
    );

     if(response.statusCode == 200){
       setState((){
         visible = false;
       });
       nameController.clear();
       emailController.clear();
       phoneNumberController.clear();
     }
     //show dialog
     showDialog(
       context: context,
       builder:(BuildContext context){
         return AlertDialog(
           title: new Text("Name: " + name + '\n' + "Email " + email + '\n' + "Mobile No. " + phoneNumber),
           actions: <Widget>[
             FlatButton(
               child: new Text('OK'),
               onPressed: (){
                 Navigator.of(context).pop();
               },
             ),
           ],
         );

       },
     );
   }
   @override
  Widget build(BuildContext context){
     return Scaffold(
       body: SingleChildScrollView(
         child: Center(
           child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Fill all information in this form', style: TextStyle(fontSize: 22)),
              ),
              Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: nameController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Enter your name here'),
                ),
              ),
              Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: emailController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Enter your email here'),
                ),
              ),
              Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: phoneNumberController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Enter your phone number here'),
                ),
              ),
              RaisedButton(
                onPressed: webCall,
                color: Colors.green,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text('Click here to submit data to server'),
              ),
              Visibility(
                visible: visible,
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
           ),
         ),
       ),
     );
   }

}



