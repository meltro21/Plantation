import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/models/varietyInfo.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
import 'package:fluttertest/screen/admin/batches/variety/varietyHistory/addVarietyInfoAdmin.dart';
import 'package:fluttertest/screen/user/varietyUser/datailVarietyInfo.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

List<VarietyInfoModel> parseVarietyInfo(String responseBody) {
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

class VarietyInfoHistory extends StatefulWidget {
  String varietyId;
  String batchNo;
  String varietyName;
  VarietyInfoHistory(this.varietyId, this.batchNo, this.varietyName);
  @override
  _VarietyInfoHistoryState createState() => _VarietyInfoHistoryState();
}

class _VarietyInfoHistoryState extends State<VarietyInfoHistory> {
  double lWidth = 100;
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );

  void smallLoading() {
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
      final pVariety = Provider.of<PVariety>(context, listen: false);
      // String varietyId =
      //     pVariety.lVariety[pVariety.currentVarietyIndex].varietyId;
      final pVarietyHistory =
          Provider.of<PVarietyHistory>(context, listen: false);
      pVarietyHistory.wrapperGetVarietyHistory(context, widget.varietyId);
      // final pRoom = Provider.of<PRoom>(context, listen: false);
      // pRoom.wrapperGetRoom(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pBatch = Provider.of<BatchP>(context);
    final pVariety = Provider.of<PVariety>(context);
    final pVarietyHistory = Provider.of<PVarietyHistory>(context);

    // final pRoom = Provider.of<PRoom>(context);
    // String varietyId =
    //     pVariety.lVariety[pVariety.currentVarietyIndex].varietyId;
    //String batchNo = pBatch.lBatch[pBatch.currentBatchIndex].batchNo;

    void showConfirmDeleteDialogBox(String varietyHistoryId) async {
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
                        smallLoading();
                        await pVarietyHistory.wrapperDeleteVarietyHistory(
                            context, widget.varietyId, varietyHistoryId);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              ));
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title:
              Text('${widget.batchNo} ${widget.varietyName} Finalized Batches'),
        ),
        body: Container(
          child: pVarietyHistory.loading
              ? Container(
                  child: Loading(),
                )
              : ListView.builder(
                  itemCount: pVarietyHistory.lVarietyHistory.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: ListTile(
                        title: Text(DateFormat.yMMMd().format(DateTime.parse(
                            pVarietyHistory.lVarietyHistory[index].createdAt))),
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
                                Container(width: lWidth, child: Text('Stage')),
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
                                    width: lWidth, child: Text('No Of Plants')),
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
                      ),
                    );
                  }),
        ));
  }
}
