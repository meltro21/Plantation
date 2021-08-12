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
        title: Text('Variety List'),
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
                                              snapshot.data[index].varietyId),
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
