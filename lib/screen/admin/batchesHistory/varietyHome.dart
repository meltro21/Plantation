import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyProvider.dart';
import 'package:fluttertest/screen/admin/batches/variety/varietyHistory/varityInfoHome.dart';
import 'package:fluttertest/screen/admin/batchesHistory/varityInfoHistory.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/variety.dart';

List<VarietyModel> parseVarieties(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<VarietyModel>((json) => VarietyModel.fromJson(json))
      .toList();
}

class VarietyHomeProcessing extends StatefulWidget {
  String batchId;
  String batchNo;
  VarietyHomeProcessing(this.batchId, this.batchNo);

  @override
  _VarietyHomeProcessingState createState() => _VarietyHomeProcessingState();
}

class _VarietyHomeProcessingState extends State<VarietyHomeProcessing> {
  double lWidth = 80;
  double rWidth = 100;
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

  @override
  Widget build(BuildContext context) {
    final pBatch = Provider.of<BatchP>(context);
    final pVariety = Provider.of<PVariety>(context);
    final pVarietyHistory = Provider.of<PVarietyHistory>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('${widget.batchNo} Finzalized Batchess'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              child: FutureBuilder(
                future: getVarities(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(snapshot.data[index].varietyName),
                              subtitle: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  snapshot.data[index].room != "null"
                                      ? Row(
                                          children: [
                                            snapshot.data[index].room != "null"
                                                ? Container(
                                                    width: lWidth,
                                                    child: Text('Room'))
                                                : SizedBox(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            snapshot.data[index].room != "null"
                                                ? Container(
                                                    child: Text(snapshot
                                                        .data[index].room),
                                                  )
                                                : SizedBox()
                                          ],
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  snapshot.data[index].stage != "null"
                                      ? Row(
                                          children: [
                                            snapshot.data[index].stage != "null"
                                                ? Container(
                                                    width: lWidth,
                                                    child: Text('Stage'))
                                                : SizedBox(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            snapshot.data[index].stage != "null"
                                                ? Container(
                                                    child: Text(snapshot
                                                        .data[index].stage),
                                                  )
                                                : SizedBox()
                                          ],
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  snapshot.data[index].noOfPlants != "null"
                                      ? Row(
                                          children: [
                                            Container(
                                                width: lWidth,
                                                child: Text('No Of Plants')),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: Text(snapshot
                                                  .data[index].noOfPlants),
                                            )
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              onTap: () {
                                // pVariety.currentVarietyIndex = index;
                                Navigator.of(context).push(MaterialPageRoute(
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
                                          child: VarietyInfoHistory(
                                              snapshot.data[index].varietyId,
                                              widget.batchNo,
                                              snapshot.data[index].varietyName),
                                        )));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             VarietyInfoHome()));
                              },
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('Error');
                  } else {
                    return Loading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
