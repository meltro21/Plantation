import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/models/batch.dart';
import 'package:fluttertest/provider/batchProvider.dart';
import 'package:fluttertest/provider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/varietyProvider.dart';
import 'package:fluttertest/provider/varietyProvider.dart';
import 'package:fluttertest/screen/admin/batches/addBatch.dart';
import 'package:fluttertest/screen/admin/batches/variety/variety.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:provider/provider.dart';

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
  // Function navigateToAdminBatches;
  // AdminBatches(this.navigateToAdminBatches);
  @override
  _AdminBatchesState createState() => _AdminBatchesState();
}

class _AdminBatchesState extends State<AdminBatches> {
  Function navigateToAdminBatches;
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

  void navigateToListVarieties(String id, String batchNo) {
    print('Navigate');
    print('id is $id');

    Navigator.push(context, MaterialPageRoute(builder: (context) => Variety()));
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
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pBatch = Provider.of<BatchP>(context, listen: false);
      pBatch.wrapperGetBatches(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pBatch = Provider.of<BatchP>(
      context,
    );
    final pVariety = Provider.of<PVariety>(
      context,
    );
    final pVarietyHistory = Provider.of<PVarietyHistory>(
      context,
    );
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
                        showLoadingDialogBox();
                        await pBatch.wrapperDeleteBatch(context, batchId);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              ));
    }

    //pBatch.wrapperGetBatches(context);
    return
        //Text('Ok');
        Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Batch List'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColorDark,
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider.value(value: pBatch),
                        ],
                        child: AddBatch(),
                      )),
            );
          },
          label: Text('Add Batch')),
      body: pBatch.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pBatch.lBatch.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //pBatch.currentBatchId = pBatch.lBatch[index].id;
                    pBatch.index = index;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider.value(value: pBatch),
                                ChangeNotifierProvider.value(value: pVariety),
                                ChangeNotifierProvider.value(
                                    value: pVarietyHistory),
                              ],
                              child: Variety(),
                            )));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Variety(
                    //             pBatch.lBatch[index].id,
                    //             navigateToAdminBatches,
                    //             navigateToListVarieties,
                    //             pBatch.lBatch[index].batchNo)));
                  },
                  child: Card(
                    color: Theme.of(context).accentColor,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Batch ${pBatch.lBatch[index].batchNo}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: GestureDetector(
                        child: Icon(Icons.highlight_off),
                        onTap: () async {
                          await showConfirmDeleteDialogBox(
                              pBatch.lBatch[index].id);
                        },
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}


// Scaffold(
//         backgroundColor: Theme.of(context).primaryColorLight,
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColorDark,
//           title: Text('Batch List'),
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//             backgroundColor: Theme.of(context).primaryColorDark,
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => AddBatch(navigateToAdminBatches)));
//             },
//             label: Text('Add Batch')),
//         body: FutureBuilder(
//             future: futureBatch,
//             builder: (context, pBatch) {
//               if (pBatch.haslBatch) {
//                 return ListView.builder(
//                     itemCount: pBatch.lBatch.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Variety(
//                                       pBatch.lBatch[index].id,
//                                       navigateToAdminBatches,
//                                       navigateToListVarieties,
//                                       pBatch.lBatch[index].batchNo)));
//                         },
//                         child: Card(
//                           color: Theme.of(context).accentColor,
//                           margin: EdgeInsets.all(10),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           child: ListTile(
//                             title: Text(
//                               'Batch ${pBatch.lBatch[index].batchNo}',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             trailing: GestureDetector(
//                               child: Icon(Icons.highlight_off),
//                               onTap: () async {
//                                 await showConfirmDeleteDialogBox(
//                                     pBatch.lBatch[index].id);
//                               },
//                             ),
//                           ),
//                         ),
//                       );
//                     });
//               } else if (pBatch.hasError) {
//                 print('pBatch has error');
//                 return ErrorOccured(pBatch.error);
//               } else {
//                 return Loading();
//               }
//             })