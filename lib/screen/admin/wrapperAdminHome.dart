import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/database/database.dart';
import 'package:fluttertest/screen/admin/adminHome.dart';

import 'package:provider/provider.dart';

class WrapperAdminHome extends StatefulWidget {
  @override
  _WrapperAdminHomeState createState() => _WrapperAdminHomeState();
}

class _WrapperAdminHomeState extends State<WrapperAdminHome> {
  @override
  Widget build(BuildContext context) {
    return AdminHome();
  }
}
