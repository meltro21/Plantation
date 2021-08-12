import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/varietyProcessModel.dart';
import 'package:http/http.dart' as http;

//get weight
List<VarietyProcessModel> parseWeight(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<VarietyProcessModel>((json) => VarietyProcessModel.fromJson(json))
      .toList();
}

Future<List<VarietyProcessModel>> getWeight(
    http.Client client, String varietyId) async {
  print('start filterVariety get');
  var queryParameters = {'VarietyId': varietyId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/processingVariety', queryParameters);
  print('Filter Variety uri is: $uri');
  final response = await http.get(uri);
  if (response.statusCode == 200) {}

  print(response);
  print('end filterVariety get');
  return parseWeight(response.body);
}

//post weight
Future<String> postWeight(
    String varietyId,
    String preProcessing,
    String aGrade,
    String bGrade,
    String shake,
    String compost,
    String totalHours,
    String noOfPlantsHarvested) async {
  final response = await http.post(
      Uri.https('hughplantation.herokuapp.com', '/processingVariety'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "VarietyId": varietyId,
        "PreProcessing": preProcessing,
        "AGrade": aGrade,
        "BGrade": bGrade,
        "Shake": shake,
        "Compost": compost,
        "NoOfPlantsHarvested": noOfPlantsHarvested,
        "TotalHours": totalHours
      }));

  if (response.statusCode == 200) {
    print('varietyProcessInfo successfully');
  } else {
    print('varietyProcessInfo Error');
  }
}

class Pweight with ChangeNotifier {
  List<VarietyProcessModel> lWeight = [];
  String vId;
  bool loading = false;

  wrapperGetWeight(context, String varietyId) async {
    vId = varietyId;
    loading = true;
    notifyListeners();
    lWeight = await getWeight(http.Client(), varietyId);
    if (lWeight.isNotEmpty && lWeight.length != 1) {
      int preProcessing = 0;
      int aGrade = 0;
      int bGrade = 0;
      int shake = 0;
      int compost = 0;
      int noOfPlantsHarvested = 0;
      int noOfHours = 0;
      VarietyProcessModel totalStats = VarietyProcessModel.empty();

      for (var i in lWeight) {
        preProcessing = preProcessing + int.parse(i.preProcessing);
        aGrade = aGrade + int.parse(i.aGrade);
        bGrade = bGrade + int.parse(i.bGrade);
        shake = shake + int.parse(i.shake);
        compost = compost + int.parse(i.compost);
        noOfPlantsHarvested = compost + int.parse(i.noOfPlantsHarvested);
        noOfHours = noOfHours + int.parse(i.totalHours);
      }
      totalStats.preProcessing = preProcessing.toString();
      totalStats.aGrade = aGrade.toString();
      totalStats.bGrade = bGrade.toString();
      totalStats.shake = shake.toString();
      totalStats.compost = compost.toString();
      totalStats.noOfPlantsHarvested = noOfPlantsHarvested.toString();
      totalStats.totalHours = noOfHours.toString();
      print('totalStats + ${totalStats.aGrade}');
      // snapshot.data.add(totalStats);
      // snapshot.data.reversed;
      // List varietyProcessModel = snapshot.data;
      lWeight.insert(0, totalStats);
    }
    loading = false;
    notifyListeners();
  }

  wrapperPostWieght(
      context,
      String varietyId,
      String preProcessing,
      String aGrade,
      String bGrade,
      String shake,
      String compost,
      String totalHours,
      String noOfPlantsHarvested) async {
    var t = await postWeight(varietyId, preProcessing, aGrade, bGrade, shake,
        compost, totalHours, noOfPlantsHarvested);
    lWeight = await getWeight(http.Client(), vId);
    if (lWeight.isNotEmpty && lWeight.length != 1) {
      int preProcessing = 0;
      int aGrade = 0;
      int bGrade = 0;
      int shake = 0;
      int compost = 0;
      int noOfPlantsHarvested = 0;
      int noOfHours = 0;
      VarietyProcessModel totalStats = VarietyProcessModel.empty();

      for (var i in lWeight) {
        preProcessing = preProcessing + int.parse(i.preProcessing);
        aGrade = aGrade + int.parse(i.aGrade);
        bGrade = bGrade + int.parse(i.bGrade);
        shake = shake + int.parse(i.shake);
        compost = compost + int.parse(i.compost);
        noOfPlantsHarvested =
            noOfPlantsHarvested + int.parse(i.noOfPlantsHarvested);
        noOfHours = noOfHours + int.parse(i.totalHours);
      }
      totalStats.preProcessing = preProcessing.toString();
      totalStats.aGrade = aGrade.toString();
      totalStats.bGrade = bGrade.toString();
      totalStats.shake = shake.toString();
      totalStats.compost = compost.toString();
      totalStats.noOfPlantsHarvested = noOfPlantsHarvested.toString();
      totalStats.totalHours = noOfHours.toString();
      print('totalStats + ${totalStats.aGrade}');
      // snapshot.data.add(totalStats);
      // snapshot.data.reversed;
      // List varietyProcessModel = snapshot.data;
      lWeight.insert(0, totalStats);
    }
    notifyListeners();
  }
}
