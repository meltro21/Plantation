import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fluttertest/models/workers.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyProvider.dart';
import 'package:fluttertest/provider/dailyWork/dailyWorkProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
import 'package:fluttertest/provider/weightProvider/weightProvider.dart';
import 'package:fluttertest/provider/workerProvider/workerProvider.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/batchesListProcessBatches.dart';
import 'package:fluttertest/screen/user/userBatches.dart';
import 'package:fluttertest/screen/user/dailyWorkEntry/homeDailyWorkEntry.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

class UserHome extends StatefulWidget {
  String uid;
  UserHome(this.uid);
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final AuthService _auth = AuthService();
  String workerName;
  void navigateToHomeDailyWorkEntry(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeDailyWorkEntry(
                  widget.uid,
                )));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pWorker = Provider.of<PWorker>(context, listen: false);
      pWorker.wrapperGetWorkers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    //batch Provider
    final pBatch = Provider.of<BatchP>(context);
    final pVariety = Provider.of<PVariety>(context);
    final pVarietyHistory = Provider.of<PVarietyHistory>(context);
    //room Provider
    final pWorker = Provider.of<PWorker>(context);
    final pRoom = Provider.of<PRoom>(context);
    final pDailyWork = Provider.of<PDailyWork>(context);
    //weightProvider
    final pWeight = Provider.of<Pweight>(context);

    print('worker is $workerName');

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Hugh Home'),
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Sign out'))
        ],
      ),
      body: pWorker.loading
          ? Container(
              child: Loading(),
            )
          : Center(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
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
                                        child: UserBatches(),
                                      )));
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Batches')),
                          ),
                        ),
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
                                              value: pRoom),
                                          ChangeNotifierProvider.value(
                                              value: pDailyWork),
                                        ],
                                        child: HomeDailyWorkEntry(widget.uid),
                                      )));
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Garden Care')),
                          ),
                        ),
                      ),
                      Card(
                        color: Theme.of(context).primaryColorDark,
                        elevation: 5,
                        child: Container(
                          height: 150,
                          width: 150,
                          child: FlatButton(
                            onPressed: () {
                              for (var i in pWorker.lWorker) {
                                if (i.firestoreId == widget.uid) {
                                  workerName = i.userName;
                                }
                              }
                              print('worker is $workerName');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider.value(
                                              value: pWeight),
                                        ],
                                        child: BatchesListProcessBatches(
                                            workerName),
                                      )));
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
