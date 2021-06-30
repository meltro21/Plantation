import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/screen/user/batchHome.dart';

import 'package:provider/provider.dart';

import '../../services/auth.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final AuthService _auth = AuthService();
  int count = 0;
  final items = List<String>.generate(20, (i) => "Item $i");

  @override
  //BUILD METHOD
  Widget build(BuildContext context) {
    // for (var i in items) {
    //   print("i is $i");
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('Sticky Finger'),
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Sign out'))
        ],
      ),
      body: Container(
        child: ListView.builder(itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print("Button is presses");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BatchHome()));
            },
            child: ListTile(
              title: Text('${items[index]}'),
            ),
          );
        }),
      ),
    );
  }
}
