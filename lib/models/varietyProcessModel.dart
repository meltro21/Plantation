import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VarietyProcessModel {
  String varietyId, aGrade, bGrade, shake, compost;

  VarietyProcessModel(
      {this.varietyId, this.aGrade, this.bGrade, this.shake, this.compost});

  factory VarietyProcessModel.fromJson(Map<String, dynamic> json) {
    return new VarietyProcessModel(
        varietyId: json['_id'].toString(),
        aGrade: json['AGrade'].toString(),
        bGrade: json['BGrade'].toString(),
        shake: json['Shake'].toString(),
        compost: json['Compost'].toString());
  }
}
