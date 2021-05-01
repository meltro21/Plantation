import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



import '../../services/auth.dart';



class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  
   final AuthService _auth = AuthService();
 
  @override
  
  Widget build(BuildContext context) {
    
       return 
         Scaffold(
        appBar: AppBar(title: Text('Home'),
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
          child: Text('adminHome')
        )
           );
  }
    
}

