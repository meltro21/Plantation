import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/models/varietyInfo.dart';
import 'package:fluttertest/provider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/varietyProvider.dart';
import 'package:fluttertest/screen/admin/batches/variety/addVarietyInfoAdmin.dart';
import 'package:fluttertest/screen/user/varietyUser/datailVarietyInfo.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

List<VarietyInfoModel> parseVarietyInfo(String responseBody) {
  String varietyUid;
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<VarietyInfoModel>((json) => VarietyInfoModel.fromJson(json))
      .toList();
}

Future<int> deleteVarietyInfo(http.Client client, String varietyInfoId) async {
  var queryParameters = {'VarietyInfoId': varietyInfoId};
  var uri = Uri.https(
      'hughplantation.herokuapp.com', '/deleteVarietyInfo', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return 1;
  } else {
    return 0;
  }
}

class VarietyInfoHome extends StatefulWidget {
  String batchNo;
  String varietyId;
  VarietyInfoHome(this.varietyId, this.batchNo);
  @override
  _VarietyInfoHomeState createState() => _VarietyInfoHomeState();
}

class _VarietyInfoHomeState extends State<VarietyInfoHome> {
  double lWidth = 100;
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );
  Future<List<VarietyInfoModel>> getVarietyInfo(http.Client client) async {
    print('start filterVariety get');
    var queryParameters = {'VarietyId': widget.varietyId};
    var uri = Uri.https(
        'hughplantation.herokuapp.com', '/varietyInfo', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);

    if (response.statusCode == 200) {}

    print(response);
    print('end filterVariety get');
    return compute(parseVarietyInfo, response.body);
  }

  void showConfirmDeleteDialogBox(String varietyInfoId) async {
    print('enter');
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
                      // Navigator.pop(context);
                      // showLoadingDialogBox();
                      // await deleteVarietyInfo(http.Client(), varietyInfoId);
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                      // widget.navigateToVarietyInfoHome(widget.varietyId);
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pVarietyHistory =
          Provider.of<PVarietyHistory>(context, listen: false);
      pVarietyHistory.wrapperGetVarietyHistory(context, widget.varietyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    final pVariety = Provider.of<PVariety>(context);
    final pVarietyHistory = Provider.of<PVarietyHistory>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text('${widget.batchNo} Variety History'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              print('pressed');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider.value(value: pVariety),
                      ChangeNotifierProvider.value(value: pVarietyHistory),
                    ],
                    child: addVarietyInfoAdmin(
                      widget.varietyId,
                      widget.batchNo,
                    )),
              ));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => addVarietyInfoAdmin(
              //             widget.varietyId,
              //             widget.batchNo,
              //             widget.navigateToVarietyInfoHome)));
            },
            label: Text('Add History')),
        body: Container(
          child: pVarietyHistory.loading
              ? Container(
                  child: Loading(),
                )
              : ListView.builder(
                  itemCount: pVarietyHistory.lVarietyHistory.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             DetailVarietyInfo(snapshot.data[index])));
                      },
                      child: Card(
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: ListTile(
                          title: Text(DateFormat.yMMMd().format(DateTime.parse(
                              pVarietyHistory
                                  .lVarietyHistory[index].createdAt))),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: lWidth, child: Text('Room Name')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(pVarietyHistory
                                      .lVarietyHistory[index].enterRoomName)
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: lWidth, child: Text('Stage')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(pVarietyHistory
                                      .lVarietyHistory[index].stage)
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: lWidth,
                                      child: Text('No Of Plants')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(pVarietyHistory
                                      .lVarietyHistory[index].noOfPlants)
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: lWidth,
                                      child: Text('Entry Into Room')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(pVarietyHistory
                                      .lVarietyHistory[index].enterRoomDate)
                                ],
                              ),
                            ],
                          ),
                          trailing: GestureDetector(
                            child: Icon(Icons.highlight_off),
                            onTap: () async {
                              print('Error');
                              await showConfirmDeleteDialogBox(
                                  pVarietyHistory.lVarietyHistory[index].id);
                            },
                          ),
                        ),
                      ),
                    );
                  }),
        ));
  }
}


// DateFormat().format(
//                               DateTime.parse(snapshot.data[index].createdAt