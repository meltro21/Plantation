import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
import 'package:fluttertest/screen/user/varietyUser/varietyHistoryList.dart';
import 'package:fluttertest/shared/loading.dart';
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

class VarietyUserHome extends StatefulWidget {
  @override
  _VarietyUserHomeState createState() => _VarietyUserHomeState();
}

class _VarietyUserHomeState extends State<VarietyUserHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pBatch = Provider.of<BatchP>(context, listen: false);
      final pVariety = Provider.of<PVariety>(context, listen: false);
      String batchId = pBatch.lBatch[pBatch.currentBatchIndex].id;
      pVariety.wrapperGetVarieties(context, batchId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pVariety = Provider.of<PVariety>(context);
    final pBatch = Provider.of<BatchP>(context);
    final pVarietyHistory = Provider.of<PVarietyHistory>(context);

    final pRoom = Provider.of<PRoom>(context);

    String batchId = pBatch.lBatch[pBatch.currentBatchIndex].id;
    String batchNo = pBatch.lBatch[pBatch.currentBatchIndex].batchNo;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Variety List'),
      ),
      body: pVariety.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pVariety.lVariety.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(pVariety.lVariety[index].varietyName),
                    onTap: () {
                      pVariety.currentVarietyIndex = index;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider.value(value: pBatch),
                                  ChangeNotifierProvider.value(value: pVariety),
                                  ChangeNotifierProvider.value(
                                      value: pVarietyHistory),
                                  ChangeNotifierProvider.value(value: pRoom),
                                ],
                                child: VarietyHistoryList(),
                              )));
                    },
                  ),
                );
              }),
    );
  }
}
