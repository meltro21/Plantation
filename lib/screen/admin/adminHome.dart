import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/batch.dart';
import 'package:fluttertest/models/workers.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyProvider.dart';
import 'package:fluttertest/provider/dailyWork/dailyWorkProvider.dart';
import 'package:fluttertest/provider/weightProvider/weightProvider.dart';
import 'package:fluttertest/provider/workerProvider/workerProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
import 'package:fluttertest/screen/admin/batches/batchHome.dart';
import 'package:fluttertest/screen/admin/batchesHistory/batchesHIstory.dart';
import 'package:fluttertest/screen/admin/gardenCare/dailyWork.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/batchesListProcessBatches.dart';
import 'package:fluttertest/screen/admin/room/roomHome.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../services/auth.dart';

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
  return compute(parseWorkers, response.body);
}

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final AuthService _auth = AuthService();
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     final pWorker = Provider.of<PWorker>(context, listen: false);
  //     pWorker.wrapperGetWorkers(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //batch Provider
    final pBatch = Provider.of<BatchP>(context);
    final pVariety = Provider.of<PVariety>(context);
    final pVarietyHistory = Provider.of<PVarietyHistory>(context);
    //Garden Care Provider
    final pWorker = Provider.of<PWorker>(context);
    final pRoom = Provider.of<PRoom>(context);
    final pDailyWork = Provider.of<PDailyWork>(context);
    //weight Provider
    final pWeight = Provider.of<Pweight>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Home'),
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Sign out'))
        ],
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Theme.of(context).primaryColorDark,
                      elevation: 5,
                      child: Container(
                        height: 150,
                        width: 150,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider.value(
                                            value: pBatch),
                                        ChangeNotifierProvider.value(
                                            value: pVariety),
                                        ChangeNotifierProvider.value(
                                            value: pVarietyHistory),
                                        ChangeNotifierProvider.value(
                                            value: pRoom),
                                      ],
                                      child: BatchHome(),
                                    )
                                // AdminBatches(
                                //     navigateToAdminBatches)
                                ));
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Batches')),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Card(
                      color: Theme.of(context).primaryColorDark,
                      elevation: 5,
                      child: Container(
                        height: 150,
                        width: 150,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider.value(
                                            value: pWorker),
                                        ChangeNotifierProvider.value(
                                            value: pDailyWork),
                                      ],
                                      child: DailyWorkHome(),
                                    )
                                // AdminBatches(
                                //     navigateToAdminBatches)
                                ));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             DailyWorkHome(
                            //                 snapshot.data)));
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Garden Care')),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Theme.of(context).primaryColorDark,
                      elevation: 5,
                      child: Container(
                        height: 150,
                        width: 150,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider.value(
                                            value: pWeight),
                                      ],
                                      child: BatchesListProcessBatches(),
                                    )
                                // AdminBatches(
                                //     navigateToAdminBatches)
                                ));

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             BatchesListProcessBatches()));
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Processing')),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Card(
                      color: Theme.of(context).primaryColorDark,
                      elevation: 5,
                      child: Container(
                        height: 150,
                        width: 150,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider.value(
                                            value: pBatch),
                                        ChangeNotifierProvider.value(
                                            value: pVariety),
                                        ChangeNotifierProvider.value(
                                            value: pVarietyHistory),
                                      ],
                                      child: BatchesHistory("0"),
                                    )
                                // AdminBatches(
                                //     navigateToAdminBatches)
                                ));
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Batch History')),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Theme.of(context).primaryColorDark,
                      elevation: 5,
                      child: Container(
                        height: 150,
                        width: 150,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider.value(
                                            value: pRoom),
                                      ],
                                      child: RoomHome(),
                                    )));
                          },
                          child: Align(
                              alignment: Alignment.center, child: Text('Room')),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
