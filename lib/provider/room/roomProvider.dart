import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertest/models/Room.dart';
import 'package:http/http.dart' as http;

//get Room
List<Room> parseRoom(String responseBody) {
  print('start parseRoom');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end parseRoom get');
  return parsed.map<Room>((json) => Room.fromJson(json)).toList();
}

Future<List<Room>> getRoom(http.Client client) async {
  print('start room get');
  final response =
      await client.get(Uri.parse('https://hughplantation.herokuapp.com/room'));

  print('response is ${response.body}');

  if (response.statusCode == 200) {}

  print(response);
  print('end room get');
  return parseRoom(response.body);
}

//post Room
Future<String> postRoom(
  String roomName,
) async {
  final response =
      await http.post(Uri.https('hughplantation.herokuapp.com', '/room'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "RoomName": roomName,
          }));

  if (response.statusCode == 200) {
    print('room added successfully');
  } else {
    print('error adding room');
  }
}

//delete Room
Future<int> deleteRoom(http.Client client, String roomId) async {
  var queryParameters = {'RoomId': roomId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', 'room/deleteRoom', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

class PRoom with ChangeNotifier {
  List<Room> lRoom = [];
  bool loading = false;

  wrapperGetRoom(context) async {
    loading = true;
    notifyListeners();
    lRoom = await getRoom(http.Client());
    loading = false;
    notifyListeners();
  }

  wrapperPostRoom(context, String roomName) async {
    var t = await postRoom(
      roomName,
    );
    lRoom = await getRoom(http.Client());
    notifyListeners();
  }

  wrapperDeleteRoom(context, String roomId) async {
    var t = await deleteRoom(
      http.Client(),
      roomId,
    );
    lRoom = await getRoom(http.Client());
    notifyListeners();
  }
}
