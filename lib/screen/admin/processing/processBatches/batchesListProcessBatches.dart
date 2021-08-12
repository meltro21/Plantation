import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/batchesHistoryModel.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/weightProvider/weightProvider.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/varietyListProcessBatches.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../services/auth.dart';

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
      .get(Uri.parse('https://hughplantation.herokuapp.com/processingBatch'));

  if (response.statusCode == 200) {}

  print(response);
  print('end batches get');
  return compute(parseBatch, response.body);
}

class BatchesListProcessBatches extends StatefulWidget {
  @override
  _BatchesListProcessBatchesState createState() =>
      _BatchesListProcessBatchesState();
}

class _BatchesListProcessBatchesState extends State<BatchesListProcessBatches> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final pWeight = Provider.of<Pweight>(
      context,
    );
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider.value(
                                            value: pWeight),
                                      ],
                                      child: VarietyListProcessBatches(
                                          snapshot.data[index].id),
                                    )),
                          );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             VarietyListProcessBatches(
                          //                 snapshot.data[index].id)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(
                              'Batch ${snapshot.data[index].batchNo}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
