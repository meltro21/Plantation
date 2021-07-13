import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class HomeDailyWorkEntry extends StatefulWidget {
  String uid;
  Function navigateToHomeDailyWorkEntry;
  HomeDailyWorkEntry(this.uid, this.navigateToHomeDailyWorkEntry);
  @override
  _HomeDailyWorkEntryState createState() => _HomeDailyWorkEntryState();
}

class _HomeDailyWorkEntryState extends State<HomeDailyWorkEntry> {
  final AuthService _auth = AuthService();

  Future<List<DailyWorkModel>> getVarities(http.Client client) async {
    print('start FilterDailyWork get');
    var queryParameters = {'firestoreId': '${widget.uid}'};
    var uri = Uri.https(
        'hughplantation.herokuapp.com', '/filterDailyWork', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);
    if (response.statusCode == 200) {}

    print(response);
    print('end filterVariety get');
    return compute(parseVarieties, response.body);
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    return Scaffold(
        appBar: AppBar(
          title: Text('Daily Work'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DailyWorkEntry(
                          widget.uid, widget.navigateToHomeDailyWorkEntry)));
            },
            label: Text('Add Daily Work')),
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
