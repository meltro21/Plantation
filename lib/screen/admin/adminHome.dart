import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/screen/admin/adminBatches.dart';
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
        body: Center(
          child:Container(
            child:SingleChildScrollView(child: Column(
              children: [
                Card(
                  elevation: 5,
                  child:Container(
                    height: 150,
                    width: 150,
                    child:FlatButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminBatches()));
                      },
                        child: Align(
                        alignment: Alignment.center,
                        child: Text('Batches')),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child:Container(
                    height: 150,
                    width: 150,
                    child:FlatButton(
                      onPressed: (){

                      },
                      child:Align(
                      alignment: Alignment.center,
                      child: Text('Workers Info')),
                      ),
                    
                  ),
                ),
              ],
            ),
            ),
          ),
        )
           );
  }
    
}

