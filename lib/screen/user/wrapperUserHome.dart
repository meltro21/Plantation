import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/database/database.dart';

import 'package:provider/provider.dart';
import 'userHome.dart';

class WrapperUserHome extends StatefulWidget {
  String uid;
  WrapperUserHome(this.uid);
  @override
  _WrapperAdminHomeState createState() => _WrapperAdminHomeState();
}

class _WrapperAdminHomeState extends State<WrapperUserHome> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: Database().CompetitionDateTime,
      initialData: null,
      child: UserHome(widget.uid),
    );
  }
}
