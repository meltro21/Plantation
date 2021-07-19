import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/models/varietyInfo.dart';
import 'package:fluttertest/screen/admin/batches/variety/addVarietyInfoAdmin.dart';
import 'package:fluttertest/screen/user/varietyUser/datailVarietyInfo.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
  String varietyId;
  Function navigateToVarietyInfoHome;
  VarietyInfoHome(this.varietyId, this.navigateToVarietyInfoHome);
  @override
  _VarietyInfoHomeState createState() => _VarietyInfoHomeState();
}

class _VarietyInfoHomeState extends State<VarietyInfoHome> {
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
                      Navigator.pop(context);
                      showLoadingDialogBox();
                      await deleteVarietyInfo(http.Client(), varietyInfoId);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      widget.navigateToVarietyInfoHome(widget.varietyId);
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
  Widget build(BuildContext context) {
    DateTime dateTime;

    return Scaffold(
        appBar: AppBar(
          title: Text('Variety History'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addVarietyInfoAdmin(
                          widget.varietyId, widget.navigateToVarietyInfoHome)));
            },
            label: Text('Add History')),
        body: FutureBuilder(
            future: getVarietyInfo(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('snapshot has data');
                for (var i in snapshot.data) {
                  print(i.enterRoomDate);
                }
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailVarietyInfo(snapshot.data[index])));
                        },
                        child: ListTile(
                          title: Text(DateFormat().format(
                              DateTime.parse(snapshot.data[index].createdAt))),
                          trailing: GestureDetector(
                            child: Icon(Icons.highlight_off),
                            onTap: () async {
                              print('Error');
                              await showConfirmDeleteDialogBox(
                                  snapshot.data[index].id);
                            },
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                print('snapshot has error');
                return snapshot.error;
              } else {
                return Loading();
              }
            }));
  }
}
