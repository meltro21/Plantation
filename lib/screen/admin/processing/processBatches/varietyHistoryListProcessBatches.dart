import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/models/batch.dart';
import 'package:fluttertest/models/varietyInfo.dart';
import 'package:fluttertest/models/varietyProcessModel.dart';
import 'package:fluttertest/screen/admin/batches/addBatch.dart';
import 'package:fluttertest/screen/admin/batches/variety/variety.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/addVarietyProcessInfo.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/detailVarietyInfoProcessBatch.dart';
import 'package:fluttertest/screen/user/varietyUser/addVarietyInfo.dart';
import 'package:fluttertest/screen/user/varietyUser/datailVarietyInfo.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List<VarietyProcessModel> parseVarietyInfo(String responseBody) {
  String varietyUid;
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<VarietyProcessModel>((json) => VarietyProcessModel.fromJson(json))
      .toList();
}

class VarietyHistoryListProcessBatches extends StatefulWidget {
  Function navigateToVarietyHistoryList;
  String varietyId;
  VarietyHistoryListProcessBatches(
      this.varietyId, this.navigateToVarietyHistoryList);
  @override
  _VarietyHistoryListProcessBatchesState createState() =>
      _VarietyHistoryListProcessBatchesState();
}

class _VarietyHistoryListProcessBatchesState
    extends State<VarietyHistoryListProcessBatches> {
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );
  Future<List<VarietyProcessModel>> getVarietyInfo(http.Client client) async {
    print('start filterVariety get');
    var queryParameters = {'VarietyId': widget.varietyId};
    var uri = Uri.https(
        'hughplantation.herokuapp.com', '/processingVariety', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);
    if (response.statusCode == 200) {}

    print(response);
    print('end filterVariety get');
    return compute(parseVarietyInfo, response.body);
  }

  void showDialogBox(bool flag) {
    showCupertinoDialog(
        context: context,
        builder: (_) => Container(
              child: AlertDialog(
                content: Container(width: 50, height: 50, child: spinkit),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    return Scaffold(
        appBar: AppBar(
          title: Text('Batches'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddVarietyProcessInfo(
                          widget.varietyId,
                          widget.navigateToVarietyHistoryList)));
            },
            label: Text('Add Batch')),
        body: FutureBuilder(
            future: getVarietyInfo(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('snapshot has data');
                for (var i in snapshot.data) {
                  print(i.aGrade);
                }
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailVarietyInfoProcessBatch(
                                          snapshot.data[index])));
                        },
                        child:
                            ListTile(title: Text(snapshot.data[index].aGrade)),
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
