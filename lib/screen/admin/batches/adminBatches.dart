import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/batch.dart';
import 'package:fluttertest/screen/admin/batches/addBatch.dart';
import 'package:fluttertest/screen/admin/batches/variety/variety.dart';
import 'package:fluttertest/shared/errorOccured.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:http/http.dart' as http;

import '../../../services/auth.dart';

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

  if (response.statusCode == 200) {}

  print(response);
  print('end batches get');
  return compute(parseBatch, response.body);
}

class AdminBatches extends StatefulWidget {
  @override
  _AdminBatchesState createState() => _AdminBatchesState();
}

class _AdminBatchesState extends State<AdminBatches> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    return Scaffold(
        appBar: AppBar(
          title: Text('Batches List'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddBatch()));
            },
            label: Text('Add Batch')),
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
                                  builder: (context) =>
                                      Variety(snapshot.data[index].id)));
                        },
                        child: ListTile(
                          title: Text('Batch ${snapshot.data[index].batchNo}'),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                print('snapshot has error');
                return ErrorOccured(snapshot.error);
              } else {
                return Loading();
              }
            }));
  }
}
