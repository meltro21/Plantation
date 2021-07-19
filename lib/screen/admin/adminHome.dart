import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/workers.dart';
import 'package:fluttertest/screen/admin/batches/adminBatches.dart';
import 'package:fluttertest/screen/admin/processing/homeProcessing.dart';
import 'package:fluttertest/screen/admin/workersInfo/dailyWork.dart';
import 'package:fluttertest/shared/loading.dart';
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

  void navigateToAdminBatches() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdminBatches(navigateToAdminBatches)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        body: FutureBuilder(
            future: getWorkers(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('snapshot has data');
                print(snapshot.data);
                for (var i in snapshot.data) {
                  print('Mongo WotkerId(firestore) ${i.firestoreId}');
                  print('Mongo UserName ${i.userName}');
                }
                // for (var i in snapshot.data) {
                //   print('naem is ${snapshot.data[i].userName}');
                // }
                return Center(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            elevation: 5,
                            child: Container(
                              height: 150,
                              width: 150,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminBatches(
                                              navigateToAdminBatches)));
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Batches')),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                              height: 150,
                              width: 150,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DailyWorkHome(snapshot.data)));
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Daily Work')),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                              height: 150,
                              width: 150,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeProcessing()));
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
                );
              } else if (snapshot.hasError) {
                return snapshot.error;
              } else {
                return Loading();
              }
            }));
  }
}
