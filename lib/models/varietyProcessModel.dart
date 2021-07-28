import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VarietyProcessModel {
  String varietyId,
      aGrade,
      bGrade,
      shake,
      compost,
      totalHours,
      noOfPlantsHarvested;

  VarietyProcessModel(
      {this.varietyId,
      this.aGrade,
      this.bGrade,
      this.shake,
      this.compost,
      this.totalHours,
      this.noOfPlantsHarvested});

  VarietyProcessModel.empty() {
    varietyId = "0";
    varietyId = "0";
    bGrade = "0";
    shake = "0";
    compost = "0";
    totalHours = "0";
    noOfPlantsHarvested = "0";
  }

  factory VarietyProcessModel.fromJson(Map<String, dynamic> json) {
    return new VarietyProcessModel(
        varietyId: json['_id'].toString(),
        aGrade: json['AGrade'].toString(),
        bGrade: json['BGrade'].toString(),
        shake: json['Shake'].toString(),
        compost: json['Compost'].toString(),
        totalHours: json['TotalHours'].toString(),
        noOfPlantsHarvested: json['NoOfPlantsHarvested'].toString());
  }
}
