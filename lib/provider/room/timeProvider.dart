import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertest/models/roomTime.dart';
import 'package:http/http.dart' as http;

//get Batch
List<RoomTime> parseRoomTime(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed.map<RoomTime>((json) => RoomTime.fromJson(json)).toList();
}

Future<List<RoomTime>> getRoomTime(http.Client client, String roomId) async {
  print('start filterVariety get');
  var queryParameters = {'roomId': roomId};
  var uri =
      Uri.https('hughplantation.herokuapp.com', '/roomTime', queryParameters);
  print('Filter Variety uri is: $uri');
  final response = await http.get(uri);

  if (response.statusCode == 200) {}

  print(response);
  print('end filterVariety get');
  return parseRoomTime(response.body);
}

//post Batch
Future<String> postRoomTime(String roomId, endDate, batchNo) async {
  final response =
      await http.post(Uri.https('hughplantation.herokuapp.com', '/roomTime'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "RoomId": roomId,
            "EndDate": endDate,
            "BatchNo": batchNo,
          }));

  if (response.statusCode == 200) {
    print('batch added successfully');
  } else {
    print('error adding batch');
  }
}

//delete Batch
Future<int> deleteRoomTime(http.Client client, String roomId) async {
  var queryParameters = {'id': roomId};
  var uri = Uri.https('hughplantation.herokuapp.com',
      '/roomTime/deleteRoomTime', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

//shift batchesToProcessing

class PRoomTime with ChangeNotifier {
  List<RoomTime> lRoomTime = [];
  //int currentBatchIndex;
  bool loading = true;

  wrapperGetRoomTime(context, String roomTime) async {
    print('wrappergetRoomTimecalled');
    loading = true;
    notifyListeners();
    lRoomTime = await getRoomTime(http.Client(), roomTime);
    loading = false;
    notifyListeners();
  }

  wrapperPostRoomTime(
      context, String roomId, String endDate, String batchNo) async {
    var t = await postRoomTime(
      roomId,
      endDate,
      batchNo,
    );
    lRoomTime = await getRoomTime(http.Client(), roomId);
    notifyListeners();
  }

  wrapperDeleteRoomTime(context, String roomId, String roomTimeId) async {
    var t = await deleteRoomTime(
      http.Client(),
      roomTimeId,
    );
    lRoomTime = await getRoomTime(http.Client(), roomId);
    notifyListeners();
  }
}
