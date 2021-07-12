import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services/auth.dart';

Future<String> postWorker(
  String firestoreId,
  String userName,
) async {
  final response =
      await http.post(Uri.https('hughplantation.herokuapp.com', '/workers'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "FirestoreId": firestoreId,
            "UserName": userName,
          }));

  if (response.statusCode == 200) {
    print('worker added successfully');
  } else {
    print('error adding worker');
  }
}

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.brown[100],
      appBar: AppBar(
        // backgroundColor: Colors.brown[400],
        // elevation: 0.0,
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.arrow_back),
              label: Text('back'))
        ],
        title: Text('Sign up'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter username' : null,
                        decoration: InputDecoration(
                            labelText: 'UserName',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: userNameController,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: emailController,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                        controller: passwordController,
                      ),
                      SizedBox(height: 5.0),
                      SizedBox(height: 40.0),
                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () async {
                              print(emailController.text);
                              print(passwordController.text);
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text);
                                if (result == null) {
                                  print('REsult is null');
                                  setState(() {
                                    error = 'Please supply a valid email';
                                  });
                                } else {
                                  print('User is ${result.uid}');
                                  postWorker(
                                      result.uid, userNameController.text);
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
