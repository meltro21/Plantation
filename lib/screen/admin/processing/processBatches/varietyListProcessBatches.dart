import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/weightProvider/weightProvider.dart';
import 'package:fluttertest/screen/admin/batches/variety/addVariety.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/addVarietyProcessInfo.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/varietyHistoryListProcessBatches.dart';
import 'package:fluttertest/screen/user/varietyUser/datailVarietyInfo.dart';
import 'package:fluttertest/screen/user/varietyUser/varietyHistoryList.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../models/variety.dart';

List<VarietyModel> parseVarieties(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<VarietyModel>((json) => VarietyModel.fromJson(json))
      .toList();
}

class VarietyListProcessBatches extends StatefulWidget {
  String batchId;
  String workerName;
  String batchNo;
  VarietyListProcessBatches(this.batchId, this.workerName, this.batchNo);

  @override
  _VarietyListProcessBatchesState createState() =>
      _VarietyListProcessBatchesState();
}

class _VarietyListProcessBatchesState extends State<VarietyListProcessBatches> {
  Future<List<VarietyModel>> getVarities(http.Client client) async {
    print('start filterVariety get');
    var queryParameters = {'batchId': widget.batchId};
    var uri = Uri.https(
        'hughplantation.herokuapp.com', '/filterVariety', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);
    if (response.statusCode == 200) {}

    print(response);
    print('end filterVariety get');
    return compute(parseVarieties, response.body);
  }

  // void navigateToVarietyHistoryList(String id) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => VarietyHistoryListProcessBatches(
  //               id, navigateToVarietyHistoryList)));
  // }

  @override
  Widget build(BuildContext context) {
    final pWeight = Provider.of<Pweight>(
      context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('${widget.batchNo} Variety List'),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => ProcessVariety()));
      //     },
      //     label: Text('Add Batch')),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              child: FutureBuilder(
                future: getVarities(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(snapshot.data[index].varietyName),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MultiProvider(
                                            providers: [
                                              ChangeNotifierProvider.value(
                                                  value: pWeight),
                                            ],
                                            child:
                                                VarietyHistoryListProcessBatches(
                                                    snapshot
                                                        .data[index].varietyId,
                                                    widget.workerName,
                                                    widget.batchNo,
                                                    snapshot.data[index]
                                                        .varietyName),
                                          )),
                                );
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             VarietyHistoryListProcessBatches(
                                //                 snapshot.data[index].varietyId,
                                //                 navigateToVarietyHistoryList)));
                              },
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('Error');
                  } else {
                    return Loading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
