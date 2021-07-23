import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/models/batch.dart';
import 'package:fluttertest/models/dailyWork.dart';
import 'package:fluttertest/models/workers.dart';
import 'package:fluttertest/screen/admin/batches/addBatch.dart';
import 'package:fluttertest/screen/admin/batches/variety/variety.dart';
import 'package:fluttertest/screen/user/dailyWorkEntry/dailyWorkEntry.dart';
import 'package:fluttertest/screen/user/dailyWorkEntry/detailDailyWork.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import '../../../services/auth.dart';

List<DailyWorkModel> parseVarieties(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<DailyWorkModel>((json) => DailyWorkModel.fromJson(json))
      .toList();
}

Future<int> deleteDailyWork(http.Client client, String dailyWorkId) async {
  var queryParameters = {'DailyWorkId': dailyWorkId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/deleteDailyWork', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

class HomeDailyWorkEntry extends StatefulWidget {
  String dailyWorkId;
  Function navigateToHomeDailyWorkEntry;
  HomeDailyWorkEntry(this.dailyWorkId, this.navigateToHomeDailyWorkEntry);
  @override
  _HomeDailyWorkEntryState createState() => _HomeDailyWorkEntryState();
}

class _HomeDailyWorkEntryState extends State<HomeDailyWorkEntry> {
  final AuthService _auth = AuthService();
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );

  Future<List<DailyWorkModel>> getVarities(http.Client client) async {
    print('start FilterDailyWork get');
    var queryParameters = {'firestoreId': '${widget.dailyWorkId}'};
    var uri = Uri.https(
        'hughplantation.herokuapp.com', '/filterDailyWork', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);
    if (response.statusCode == 200) {}

    print(response);
    print('end filterVariety get');
    return compute(parseVarieties, response.body);
  }

  void showDialogBox() {
    showCupertinoDialog(
        context: context,
        builder: (_) => Container(
              child: AlertDialog(
                content: Container(width: 50, height: 50, child: spinkit),

                // actions: [
                //   FlatButton(
                //     onPressed: () {za
                //       Navigator.pop(context);
                //     },
                //     child: Text('No'),
                //   ),
                //   FlatButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     child: Text('Ok'),
                //   ),
                // ],
              ),
            ));
  }

  void showConfirmDeleteDialogBox(String varietyId) async {
    showCupertinoDialog(
        context: context,
        builder: (_) => Container(
              child: AlertDialog(
                content: Text(' will be deleted!'),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      showDialogBox();
                      await deleteDailyWork(http.Client(), varietyId);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      widget.navigateToHomeDailyWorkEntry(widget.dailyWorkId);
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    return Scaffold(
        appBar: AppBar(
          title: Text('Garden History'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DailyWorkEntry(widget.dailyWorkId,
                          widget.navigateToHomeDailyWorkEntry)));
            },
            label: Text('Add Garden History')),
        body: FutureBuilder(
            future: getVarities(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('snapshot has data');

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailDailyWork(snapshot.data[index])));
                        },
                        child: ListTile(
                          title: Text(snapshot.data[index].createdAt),
                          trailing: GestureDetector(
                            child: Icon(Icons.highlight_off),
                            onTap: () async {
                              print('Error');
                              await showConfirmDeleteDialogBox(
                                  snapshot.data[index].id);
                            },
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
