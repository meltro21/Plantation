import 'package:flutter/material.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
import 'package:fluttertest/screen/user/varietyUser/varietyUserHome.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:provider/provider.dart';

import '../../../services/auth.dart';

class UserBatches extends StatefulWidget {
  @override
  _UserBatchesState createState() => _UserBatchesState();
}

class _UserBatchesState extends State<UserBatches> {
  final AuthService _auth = AuthService();

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
    final pRoom = Provider.of<PRoom>(
      context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Batch List'),
      ),
      body: pBatch.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pBatch.lBatch.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    pBatch.currentBatchIndex = index;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider.value(value: pBatch),
                                ChangeNotifierProvider.value(value: pVariety),
                                ChangeNotifierProvider.value(
                                    value: pVarietyHistory),
                                ChangeNotifierProvider.value(value: pRoom),
                              ],
                              child: VarietyUserHome(),
                            )));
                  },
                  child: Card(
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text('Batch ${pBatch.lBatch[index].batchNo}'),
                    ),
                  ),
                );
              }),
    );
  }
}
