import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/batch.dart';
import 'package:fluttertest/models/batchesHistoryModel.dart';
import 'package:fluttertest/screen/admin/batches/addBatch.dart';
import 'package:fluttertest/screen/admin/batches/variety/variety.dart';
import 'package:fluttertest/screen/admin/batchesHistory/varietyHome.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:http/http.dart' as http;

import '../../../services/auth.dart';

List<BatchHistoryModel> parseBatch(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<BatchHistoryModel>((json) => BatchHistoryModel.fromJson(json))
      .toList();
}

Future<List<BatchHistoryModel>> getBatches(http.Client client) async {
  print('start batches get');
  final response = await client
      .get(Uri.parse('https://hughplantation.herokuapp.com/batchesHistory'));

  if (response.statusCode == 200) {}

  print(response);
  print('end batches get');
  return compute(parseBatch, response.body);
}

class BatchesHistory extends StatefulWidget {
  String batchNo;
  BatchesHistory(this.batchNo);
  @override
  _BatchesHistoryState createState() => _BatchesHistoryState();
}

class _BatchesHistoryState extends State<BatchesHistory> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text('Batches'),
        ),
        body: FutureBuilder(
            future: getBatches(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('snapshot has data');
                for (var i in snapshot.data) {
                  print(i.enterRoomDate);
                }
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VarietyHomeProcessing(
                                      snapshot.data[index].id,
                                      widget.batchNo)));
                        },
                        child: Card(
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title:
                                Text('Batch ${snapshot.data[index].batchNo}'),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                print('snapshot has error');
                return snapshot.error;
              } else {
                return Loading();
              }
            }));
  }
}
