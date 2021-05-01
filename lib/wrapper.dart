
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/screen/admin/wrapperAdminHome.dart';
import 'package:fluttertest/screen/user/wrapperUserHome.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';



import './authenticate/authenticate.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
 
  @override
  Widget build(BuildContext context) {

   final user = Provider.of<User>(context);
   var firestoreInstance = FirebaseFirestore.instance;

  
   
    // return either the Home or Authenticate widget
    if(user==null) {
     return  Authenticate();
      }
      else
      {
         if(user.uid!='Lrn8iIoM7nRFReK4phSDHNFdq2B2')
         {
           print('In if Loop');
           print('uid is ${user.uid}');
           firestoreInstance.collection('Position').doc(user.uid).get().then((value) {
          print(value.data()['PlayTime']);
           print('value is ${value.data()["PlayTime"]}');
            if(value.data()["PlayTime"]==null)
            {
              print('Field created with value 0');
              firestoreInstance.collection('Position').doc(user.uid).set({'PlayTime':0});
              print('In if Loop with ${user.uid}');
            }
           }).onError((error, stackTrace) async {
            
             firestoreInstance.collection('Position').doc(user.uid).set({
            'Email':user.email,
            'PlayTime':0});
           });
         }
         print('didnt go');
        return user.uid=='Lrn8iIoM7nRFReK4phSDHNFdq2B2'? WrapperAdminHome():WrapperUserHome();
      }
  }

}