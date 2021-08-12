import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VarietyModel {
  String varietyId, batchId, varietyName, room, stage, noOfPlants;

  VarietyModel(
      {this.varietyId,
      this.batchId,
      this.varietyName,
      this.room,
      this.stage,
      this.noOfPlants});

  factory VarietyModel.fromJson(Map<String, dynamic> json) {
    return new VarietyModel(
        varietyId: json['_id'].toString(),
        batchId: json['BatchId'].toString(),
        varietyName: json['VarietyName'].toString(),
        room: json['Room'].toString(),
        stage: json['Stage'].toString(),
        noOfPlants: json['NoOfPlants'].toString());
  }
}
