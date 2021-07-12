import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/screen/admin/batches/variety/addVariety.dart';
import 'package:fluttertest/screen/admin/batches/variety/varityInfoHome.dart';
import 'package:fluttertest/screen/user/varietyUser/datailVarietyInfo.dart';
import 'package:fluttertest/screen/user/varietyUser/varietyHistoryList.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:http/http.dart' as http;
import '../../../../models/variety.dart';

List<VarietyModel> parseVarieties(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<VarietyModel>((json) => VarietyModel.fromJson(json))
      .toList();
}

class Variety extends StatefulWidget {
  String batchId;
  Variety(this.batchId);

  @override
  _VarietyState createState() => _VarietyState();
}

class _VarietyState extends State<Variety> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Variety List'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddVariety(widget.batchId)));
          },
          label: Text('Add Variety')),
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
                          return ListTile(
                            title: Text(snapshot.data[index].varietyName),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VarietyInfoHome(
                                          snapshot.data[index].varietyId)));
                            },
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
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 40.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.greenAccent,
                color: Colors.blue,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () async {
                    await getShiftBatches(http.Client());
                  },
                  child: Center(
                    child: Text(
                      'Add to Processing',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
