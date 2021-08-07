import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/batchProvider.dart';
import 'package:fluttertest/provider/varietyProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<String> postVariety(
    String batchId, String varietyName, String varietyNoOfPlants) async {
  print("In PostVariety");
  final response = await http.post(
      Uri.https('hughplantation.herokuapp.com', '/variety'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "BatchId": batchId,
        "VarietyName": varietyName,
        "NoOfPlants": varietyNoOfPlants
      }));
  if (response.statusCode == 200) {
    print('Variety added successfully');
  }
}

class AddVariety extends StatefulWidget {
  @override
  _AddVarietyState createState() => _AddVarietyState();
}

class _AddVarietyState extends State<AddVariety> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController varietyNameController = TextEditingController();
  TextEditingController varietyNoOfPlantsController = TextEditingController();
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );

  void showDialogBox() {
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
    final pBatch = Provider.of<BatchP>(context);
    final pVariety = Provider.of<PVariety>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Add Variety Data'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
            child: Column(children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter Variety' : null,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: varietyNameController,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    showDialogBox();
                    await pVariety.wrapperPostVarieties(
                        context,
                        pBatch.lBatch[pBatch.index].id,
                        varietyNameController.text,
                        varietyNoOfPlantsController.text);

                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Theme.of(context).primaryColorDark,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'Upload Variety',
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
          )
        ])),
      ),
    );
  }
}
