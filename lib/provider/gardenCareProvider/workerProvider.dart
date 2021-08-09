import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertest/models/workers.dart';
import 'package:http/http.dart' as http;

//get Workers
List<WorkerModel> parseWorkers(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed.map<WorkerModel>((json) => WorkerModel.fromJson(json)).toList();
}

Future<List<WorkerModel>> getWorkers(http.Client client) async {
  print('start workers get');
  final response = await client
      .get(Uri.parse('https://hughplantation.herokuapp.com/workers'));

  if (response.statusCode == 200) {}

  print(response);
  print('end workers get');
  return parseWorkers(response.body);
}

class PWorker with ChangeNotifier {
  List<WorkerModel> lWorker;
  bool loading = true;
  wrapperGetWorkers(context) async {
    loading = true;
    lWorker = await getWorkers(http.Client());
    loading = false;
    notifyListeners();
  }
}
