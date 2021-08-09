import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/varietyInfo.dart';
import 'package:http/http.dart' as http;

//get VarietyHistory
List<VarietyInfoModel> parseVarietyInfo(String responseBody) {
  String varietyUid;
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<VarietyInfoModel>((json) => VarietyInfoModel.fromJson(json))
      .toList();
}

Future<List<VarietyInfoModel>> getVarietyHistory(
    http.Client client, String varietyId) async {
  print('start filterVariety get');
  var queryParameters = {'VarietyId': varietyId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/varietyInfo', queryParameters);
  print('Filter Variety uri is: $uri');
  final response = await http.get(uri);

  if (response.statusCode == 200) {}

  print(response);
  print('end filterVariety get');
  return compute(parseVarietyInfo, response.body);
}

//post VarietyHistory
Future<String> postVarietyHistory(String varietyId, String roomName,
    String stage, String noOfPlants, String entryIntoRoom) async {
  print("In PostVariety");
  final response =
      await http.post(Uri.https('hughplantation.herokuapp.com', '/varietyInfo'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "VarietyId": varietyId,
            "EnterRoomName": roomName,
            "Stage": stage,
            "NoOfPlants": noOfPlants,
            "EnterRoomDate": entryIntoRoom
          }));
  if (response.statusCode == 200) {
    print('VarietyInfo added successfully');
  }
}

//delete Variety
Future<int> deleteVarietyHistory(
    http.Client client, String varietyInfoId) async {
  var queryParameters = {'VarietyInfoId': varietyInfoId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/deleteVarietyInfo', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

class PVarietyHistory with ChangeNotifier {
  List<VarietyInfoModel> lVarietyHistory;
  bool loading = true;

  wrapperGetVarietyHistory(context, String varietyId) async {
    loading = true;
    notifyListeners();
    lVarietyHistory = await getVarietyHistory(http.Client(), varietyId);
    loading = false;
    notifyListeners();
  }

  wrapperPostVarietyHistory(context, String varietyId, roomName, stage,
      noOfPlants, entryIntoRoom) async {
    await postVarietyHistory(
        varietyId, roomName, stage, noOfPlants, entryIntoRoom);
    lVarietyHistory = await getVarietyHistory(http.Client(), varietyId);
    notifyListeners();
  }

  wrapperDeleteVarietyHistory(context, String varietyHistoryId) async {
    await deleteVarietyHistory(http.Client(), varietyHistoryId);
    lVarietyHistory = await getVarietyHistory(http.Client(), varietyHistoryId);
    notifyListeners();
  }
}
