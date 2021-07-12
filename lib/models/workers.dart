import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkerModel {
  String firestoreId, userName;

  WorkerModel({this.firestoreId, this.userName});

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return new WorkerModel(
        firestoreId: json['FirestoreId'].toString(),
        userName: json['UserName'].toString());
  }
}
