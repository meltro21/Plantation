import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/batchProvider.dart';
import 'package:fluttertest/provider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/varietyProvider.dart';
import 'package:fluttertest/screen/admin/batches/variety/addVariety.dart';
import 'package:fluttertest/screen/admin/batches/variety/varityInfoHome.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Variety extends StatefulWidget {
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

  Future<String> getShiftBatches(http.Client client) async {
    print('start getShiftBatches get');
    var queryParameters = {'BatchId': "1234"}; //TODO:cchange 1234 to batchId
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

  void smallLoading() {
    showCupertinoDialog(
        context: context,
        builder: (_) => Container(
              child: AlertDialog(
                content: Container(width: 50, height: 50, child: spinkit),
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
                      smallLoading();
                      await getShiftBatches(http.Client());
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pBatch = Provider.of<BatchP>(context, listen: false);
      final pVariety = Provider.of<PVariety>(context, listen: false);
      String batchId = pBatch.lBatch[pBatch.index].id;
      pVariety.wrapperGetVarieties(context, batchId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pVariety = Provider.of<PVariety>(context);
    final pBatch = Provider.of<BatchP>(context);
    final pVarietyHistory = Provider.of<PVarietyHistory>(context);

    String batchId = pBatch.lBatch[pBatch.index].id;
    String batchNo = pBatch.lBatch[pBatch.index].batchNo;

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
                        smallLoading();
                        await pVariety.wrapperDeleteVarieties(
                            context, batchId, varietyId);
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
        title: Text('$batchNo Varieties'),
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
                          ChangeNotifierProvider.value(value: pBatch),
                          ChangeNotifierProvider.value(value: pVariety),
                        ],
                        child: AddVariety(),
                      )),
            );
          },
          label: Text('Add Variety')),
      body: Container(
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
                                      pVariety.lVariety[index].stage != "null"
                                          ? Container(
                                              width: lWidth,
                                              child: Text('Stage'))
                                          : SizedBox(),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      pVariety.lVariety[index].stage != "null"
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
                          pVariety.index = index;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider.value(
                                            value: pBatch),
                                        ChangeNotifierProvider.value(
                                            value: pVariety),
                                        ChangeNotifierProvider.value(
                                            value: pVarietyHistory),
                                      ],
                                      child: VarietyInfoHome(),
                                    )),
                          );
                        },
                      ),
                    );
                  })),
    );
  }
}
