import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BatchHistoryModel {
  String id,
      batchNo,
      enterRoomName,
      enterRoomDate,
      noOfPlantsHarvested,
      harvestDate;

  BatchHistoryModel(
      {this.id,
      this.batchNo,
      this.enterRoomDate,
      this.enterRoomName,
      this.noOfPlantsHarvested,
      this.harvestDate});

  factory BatchHistoryModel.fromJson(Map<String, dynamic> json) {
    return new BatchHistoryModel(
      id: json['BatchId'].toString(),
      batchNo: json['BatchNo'].toString(),
      enterRoomName: json['EnterRoomName'].toString(),
      enterRoomDate: json['EnterRoomDate'].toString(),
      noOfPlantsHarvested: json['NoOfPlantsHarvested'].toString(),
      harvestDate: json['HarvestDate'].toString(),
    );
  }
}