import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/variety.dart';
import 'package:http/http.dart' as http;

//get Varieties
List<VarietyModel> parseVarieties(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<VarietyModel>((json) => VarietyModel.fromJson(json))
      .toList();
}

Future<List<VarietyModel>> getVarities(
    http.Client client, String batchId) async {
  print('start filterVariety get');
  var queryParameters = {'batchId': batchId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/filterVariety', queryParameters);
  print('Filter Variety uri is: $uri');
  final response = await http.get(uri);
  if (response.statusCode == 200) {}

  print(response);
  print('end filterVariety get');
  return compute(parseVarieties, response.body);
}

//post Varieties
Future<String> postVariety(
    String batchId, String varietyName, String varietyNoOfPlants) async {
  print("In PostVariety");
  final response = await http.post(
      Uri.https('hughplantation.herokuapp.com', '/variety'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "BatchId": batchId,
        "VarietyName": varietyName,
        "NoOfPlants": varietyNoOfPlants
      }));
  if (response.statusCode == 200) {
    print('Variety added successfully');
  }
}

//delete Varieties
Future<int> deleteVariety(http.Client client, String varietyId) async {
  var queryParameters = {'VarietyId': varietyId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/deleteVariety', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

class PVariety with ChangeNotifier {
  List<VarietyModel> lVariety;
  bool loading = true;

  wrapperGetVarieties(context, String batchId) async {
    loading = true;
    notifyListeners();
    lVariety = await getVarities(http.Client(), batchId);
    loading = false;
    notifyListeners();
  }

  wrapperPostVarieties(context, String batchId, String varietyName,
      String varietyNoOfPlants) async {
    //loading = true;
    var t = await postVariety(batchId, varietyName, varietyNoOfPlants);
    lVariety = await getVarities(http.Client(), batchId);
    // loading = false;
    notifyListeners();
  }

  wrapperDeleteVarieties(context, String batchId, String varietyId) async {
    var t = await deleteVariety(http.Client(), varietyId);
    lVariety = await getVarities(http.Client(), batchId);
    notifyListeners();
  }
}
