import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/batchProvider.dart';
import 'package:fluttertest/provider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/varietyProvider.dart';
import 'package:fluttertest/screen/admin/batches/addBatch.dart';
import 'package:fluttertest/screen/admin/batches/variety/variety.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:provider/provider.dart';

class AdminBatches extends StatefulWidget {
  @override
  _AdminBatchesState createState() => _AdminBatchesState();
}

class _AdminBatchesState extends State<AdminBatches> {
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
                        smallLoading();
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

    return Scaffold(
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
