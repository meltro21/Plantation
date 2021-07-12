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
    if (user == null) {
      return Authenticate();
    } else {
      return user.uid == '4YXjBmjSdMZgflxvmz5NRtW24Ce2'
          ? WrapperAdminHome()
          : WrapperUserHome(user.uid);
    }
  }
}
