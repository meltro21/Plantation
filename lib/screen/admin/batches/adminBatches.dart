import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

Future<int> deleteBatch(http.Client client, String batchId) async {
  var queryParameters = {'BatchId': batchId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/deleteBatch', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

class AdminBatches extends StatefulWidget {
  Function navigateToAdminBatches;
  AdminBatches(this.navigateToAdminBatches);
  @override
  _AdminBatchesState createState() => _AdminBatchesState();
}

class _AdminBatchesState extends State<AdminBatches> {
  Future<List<Batch>> futureBatch;
  final AuthService _auth = AuthService();
  void adminBatchesPop() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );

  void navigateToListVarieties(String id) {
    print('Navigate');
    print('id is $id');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Variety(
                id, widget.navigateToAdminBatches, navigateToListVarieties)));
  }

  void showConfirmDeleteDialogBox(String batchId) async {
    showCupertinoDialog(
        context: context,
        builder: (_) => Container(
              child: AlertDialog(
                content: Text('Are you sure you want to delete!'),
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
                      showLoadingDialogBox();
                      await deleteBatch(http.Client(), batchId);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      widget.navigateToAdminBatches();
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            ));
  }

  void showLoadingDialogBox() {
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
    // TODO: implement initState
    super.initState();
    futureBatch = getBatches(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    return Scaffold(
        appBar: AppBar(
          title: Text('Batch List'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddBatch(widget.navigateToAdminBatches)));
            },
            label: Text('Add Batch')),
        body: FutureBuilder(
            future: futureBatch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Variety(
                                      snapshot.data[index].id,
                                      widget.navigateToAdminBatches,
                                      navigateToListVarieties)));
                        },
                        child: ListTile(
                          title: Text('Batch ${snapshot.data[index].batchNo}'),
                          trailing: GestureDetector(
                            child: Icon(Icons.highlight_off),
                            onTap: () async {
                              await showConfirmDeleteDialogBox(
                                  snapshot.data[index].id);
                            },
                          ),
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
