import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/varietyProvider.dart';
import 'package:fluttertest/screen/admin/batches/adminBatches.dart';
import 'package:fluttertest/screen/admin/batches/variety/addVariety.dart';
import 'package:fluttertest/screen/admin/batches/variety/varityInfoHome.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../models/variety.dart';

List<VarietyModel> parseVarieties(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<VarietyModel>((json) => VarietyModel.fromJson(json))
      .toList();
}

Future<int> deleteVariety(http.Client client, String varietyId) async {
  var queryParameters = {'VarietyId': varietyId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/deleteVariety', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

class Variety extends StatefulWidget {
  String batchNo;
  String batchId;
  Variety(this.batchId, this.batchNo);

  @override
  _VarietyState createState() => _VarietyState();
}

class _VarietyState extends State<Variety> {
  double lWidth = 80;
  double rWidth = 100;
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );
  Future<List<VarietyModel>> getVarities(http.Client client) async {
    print('start filterVariety get');
    var queryParameters = {'batchId': widget.batchId};
    var uri = Uri.https(
        'hughplantation.herokuapp.com', '/filterVariety', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);
    if (response.statusCode == 200) {}

    print(response);
    print('end filterVariety get');
    return compute(parseVarieties, response.body);
  }

  Future<String> getShiftBatches(http.Client client) async {
    print('start getShiftBatches get');
    var queryParameters = {'BatchId': widget.batchId};
    var uri = Uri.https(
        'hughplantation.herokuapp.com', '/shiftBatches', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print('successfully shifted batch');
      return 'success';
    } else {
      print('error shifting batch');
      return 'error';
    }
  }

  void navigateToVarietyInfoHome(String id, String batchNo) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VarietyInfoHome(id, batchNo, navigateToVarietyInfoHome)));
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

  void showConfirmAddToProcessing() async {
    showCupertinoDialog(
        context: context,
        builder: (_) => Container(
              child: AlertDialog(
                content: Text(' will be shifted to Processing'),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      showDialogBox();
                      await getShiftBatches(http.Client());
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);

                      //  widget.navigateToAdminBatches();
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pVariety = Provider.of<PVariety>(context, listen: false);
      pVariety.wrapperGetVarieties(context, widget.batchId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pVariety = Provider.of<PVariety>(context);

    void showConfirmDeleteDialogBox(
        String varietyName, String varietyId) async {
      showCupertinoDialog(
          context: context,
          builder: (_) => Container(
                child: AlertDialog(
                  content: Text('$varietyName will be deleted!'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () async {
                        showDialogBox();
                        await pVariety.wrapperDeleteVarieties(
                            context, widget.batchId, varietyId);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // showDialogBox();

                        // await deleteVariety(http.Client(), varietyId);
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                        // widget.navigateToListVarieties(
                        //     widget.batchId, widget.batchNo);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              ));
    }

    print('hello');
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('${widget.batchNo} Varieties'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                await showConfirmAddToProcessing();
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider.value(value: pVariety),
                        ],
                        child: AddVariety(widget.batchId),
                      )),
            );
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => AddVariety(
            //             widget.batchId, widget.navigateToListVarieties)));
          },
          label: Text('Add Variety')),
      body: Container(
        child: Column(
          children: [
            Container(
                height: 300,
                child: pVariety.loading
                    ? Container(
                        child: Loading(),
                      )
                    : ListView.builder(
                        itemCount: pVariety.lVariety.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Theme.of(context).accentColor,
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(
                                pVariety.lVariety[index].varietyName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  pVariety.lVariety[index].stage != "null"
                                      ? Row(
                                          children: [
                                            pVariety.lVariety[index].stage !=
                                                    "null"
                                                ? Container(
                                                    width: lWidth,
                                                    child: Text('Stage'))
                                                : SizedBox(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            pVariety.lVariety[index].stage !=
                                                    "null"
                                                ? Container(
                                                    child: Text(pVariety
                                                        .lVariety[index].stage),
                                                  )
                                                : SizedBox()
                                          ],
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  pVariety.lVariety[index].noOfPlants != "null"
                                      ? Row(
                                          children: [
                                            Container(
                                                width: lWidth,
                                                child: Text('No Of Plants')),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: Text(pVariety
                                                  .lVariety[index].noOfPlants),
                                            )
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              trailing: GestureDetector(
                                  onTap: () async {
                                    print('pressed');
                                    await showConfirmDeleteDialogBox(
                                        pVariety.lVariety[index].varietyName,
                                        pVariety.lVariety[index].varietyId);
                                    //Navigator.pop(context);
                                  },
                                  child: Icon(Icons.highlight_off)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VarietyInfoHome(
                                            pVariety.lVariety[index].varietyId,
                                            widget.batchNo,
                                            navigateToVarietyInfoHome)));
                              },
                            ),
                          );
                        })),
            // SizedBox(height: 20),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   height: 40.0,
            //   child: Material(
            //     borderRadius: BorderRadius.circular(20.0),
            //     shadowColor: Colors.greenAccent,
            //     color: Colors.blue,
            //     elevation: 7.0,
            //     child: GestureDetector(
            //       onTap: () async {
            //         showDialogBox();
            //         await getShiftBatches(http.Client());
            //         Navigator.pop(context);
            //         Navigator.pop(context);
            //         Navigator.pop(context);

            //         widget.navigateToAdminBatches();
            //       },
            //       child: Center(
            //         child: Text(
            //           'Add to Processing',
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //               fontFamily: 'Montserrat'),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
