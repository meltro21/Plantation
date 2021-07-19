import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/screen/user/varietyUser/addVarietyInfo.dart';
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

class VarietyUserHome extends StatefulWidget {
  String batchId;
  VarietyUserHome(this.batchId);

  @override
  _VarietyUserHomeState createState() => _VarietyUserHomeState();
}

class _VarietyUserHomeState extends State<VarietyUserHome> {
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

  void navigateToVarietyInfoHome(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VarietyHistoryList(id, navigateToVarietyInfoHome)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Variety List'),
      ),
      body: FutureBuilder(
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
                              builder: (context) => VarietyHistoryList(
                                  snapshot.data[index].varietyId,
                                  navigateToVarietyInfoHome)));
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
    );
  }
}
