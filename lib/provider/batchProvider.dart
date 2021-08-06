import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertest/models/batch.dart';
import 'package:http/http.dart' as http;

//get Batch
List<Batch> parseBatch(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed.map<Batch>((json) => Batch.fromJson(json)).toList();
}

Future<List<Batch>> getBatches(http.Client client) async {
  print('start batches get');
  final response = await client
      .get(Uri.parse('https://hughplantation.herokuapp.com/batches'));

  print('response is ${response.body}');

  if (response.statusCode == 200) {}

  print(response);
  print('end batches get');
  return parseBatch(response.body);
}

//post Batch
Future<String> postBatch(
  String batchNo,
) async {
  final response =
      await http.post(Uri.https('hughplantation.herokuapp.com', '/batches'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "BatchNo": batchNo,
          }));

  if (response.statusCode == 200) {
    print('batch added successfully');
  } else {
    print('error adding batch');
  }
}

//delete Batch
Future<int> deleteBatch(http.Client client, String batchId) async {
  var queryParameters = {'BatchId': batchId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/deleteBatch', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

class BatchP with ChangeNotifier {
  List<Batch> lBatch = [];
  List<Batch> tempBatch = [];
  bool loading = false;

  wrapperGetBatches(context) async {
    //lBatch.add(Batch(batchNo: "10", id: "00"));
    loading = true;
    notifyListeners();
    lBatch = await getBatches(http.Client());
    print('temp batch is $tempBatch');
    loading = false;
    notifyListeners();
    // notifyListeners();
  }

  wrapperPostBatch(context, String batchNo) async {
    var t = await postBatch(
      batchNo,
    );
    lBatch = await getBatches(http.Client());
    notifyListeners();
  }

  wrapperDeleteBatch(context, String batchId) async {
    var t = await deleteBatch(
      http.Client(),
      batchId,
    );
    lBatch = await getBatches(http.Client());
    notifyListeners();
  }
}
