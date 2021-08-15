import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/models/batch.dart';
import 'package:fluttertest/models/varietyInfo.dart';
import 'package:fluttertest/models/varietyProcessModel.dart';
import 'package:fluttertest/models/varietyProcessModel.dart';
import 'package:fluttertest/provider/weightProvider/weightProvider.dart';
import 'package:fluttertest/screen/admin/batches/addBatch.dart';
import 'package:fluttertest/screen/admin/batches/variety/variety.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/addVarietyProcessInfo.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/detailVarietyInfoProcessBatch.dart';
import 'package:fluttertest/screen/user/varietyUser/addVarietyInfo.dart';
import 'package:fluttertest/screen/user/varietyUser/datailVarietyInfo.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  String varietyId;
  String workerName;
  VarietyHistoryListProcessBatches(this.varietyId, this.workerName);
  @override
  _VarietyHistoryListProcessBatchesState createState() =>
      _VarietyHistoryListProcessBatchesState();
}

class _VarietyHistoryListProcessBatchesState
    extends State<VarietyHistoryListProcessBatches> {
  double lWidth = 100;
  double rwidth = 60;
  Future<List<VarietyProcessModel>> futureVarietyProcess;
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pBatch = Provider.of<Pweight>(context, listen: false);
      pBatch.wrapperGetWeight(context, widget.varietyId);
    });
    // futureVarietyProcess =
    //     getVarietyInfo(http.Client()) as Future<List<VarietyProcessModel>>;
  }

  @override
  Widget build(BuildContext context) {
    final pWeight = Provider.of<Pweight>(
      context,
    );

    // int aGrade = 0;
    //             int bGrade = 0;
    //             int shake = 0;
    //             int compost = 0;
    //             int noOfPlantsHarvested = 0;
    //             int noOfHours = 0;
    //             VarietyProcessModel totalStats = VarietyProcessModel.empty();

    //             for (var i in snapshot.data) {
    //               aGrade = aGrade + int.parse(i.aGrade);
    //               bGrade = bGrade + int.parse(i.bGrade);
    //               shake = shake + int.parse(i.shake);
    //               compost = compost + int.parse(i.compost);
    //               noOfPlantsHarvested =
    //                   compost + int.parse(i.noOfPlantsHarvested);
    //               noOfHours = noOfHours + int.parse(i.totalHours);
    //             }
    //             totalStats.aGrade = aGrade.toString();
    //             totalStats.bGrade = bGrade.toString();
    //             totalStats.shake = shake.toString();
    //             totalStats.compost = compost.toString();
    //             totalStats.noOfPlantsHarvested = noOfPlantsHarvested.toString();
    //             totalStats.totalHours = noOfHours.toString();
    //             print('totalStats + ${totalStats.aGrade}');
    //             // snapshot.data.add(totalStats);
    //             // snapshot.data.reversed;
    //             List varietyProcessModel = snapshot.data;
    //             varietyProcessModel.insert(0, totalStats);
    DateTime dateTime;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Weight'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider.value(value: pWeight),
                      ],
                      child: AddVarietyProcessInfo(
                          widget.varietyId, widget.workerName),
                    )));
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => AddVarietyProcessInfo(
            //             widget.varietyId,
            //             widget.navigateToVarietyHistoryList)));
          },
          label: Text(
            'Add Info',
            style: TextStyle(color: Colors.white),
          )),
      body: pWeight.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pWeight.lWeight.length,
              itemBuilder: (context, index) {
                return Container(
                  color: index == 0 ? Colors.lightGreen : Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DetailVarietyInfoProcessBatch(
                      //             snapshot.data[index])));
                    },
                    child: Card(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        // title: Text(snapshot.data[index].aGrade),
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: lWidth,
                                  child: Text(
                                    'PreProcessing',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  ' ${pWeight.lWeight[index].preProcessing} g',
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: lWidth,
                                  child: Text(
                                    'A Grade',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  ' ${pWeight.lWeight[index].aGrade} g',
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: lWidth,
                                  child: Text(
                                    'B Grade',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${pWeight.lWeight[index].bGrade} g',
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: lWidth,
                                  child: Text(
                                    'Shake',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${pWeight.lWeight[index].shake} g',
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: lWidth,
                                  child: Text(
                                    'Compost',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${pWeight.lWeight[index].compost} g',
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: lWidth,
                                  child: Text(
                                    'NoOfPlants',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${pWeight.lWeight[index].noOfPlantsHarvested} ',
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: lWidth,
                                  child: Text(
                                    'Total Hours',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${pWeight.lWeight[index].totalHours} ',
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: lWidth,
                                  child: Text(
                                    'Processed By',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${pWeight.lWeight[index].workerName} ',
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
