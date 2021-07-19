import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VarietyInfoModel {
  String id, enterRoomName, enterRoomDate, noOfPlants, createdAt;

  VarietyInfoModel(
      {this.id,
      this.enterRoomDate,
      this.enterRoomName,
      this.noOfPlants,
      this.createdAt});

  factory VarietyInfoModel.fromJson(Map<String, dynamic> json) {
    return new VarietyInfoModel(
      id: json['_id'].toString(),
      enterRoomName: json['EnterRoomName'].toString(),
      enterRoomDate: json['EnterRoomDate'].toString(),
      noOfPlants: json['NoOfPlants'].toString(),
      createdAt: json['CreatedAt'].toString(),
    );
  }
}
