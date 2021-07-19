import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

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
  String batchId;
  Function navigateToListVarieties;
  AddVariety(this.batchId, this.navigateToListVarieties);

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

                // actions: [
                //   FlatButton(
                //     onPressed: () {za
                //       Navigator.pop(context);
                //     },
                //     child: Text('No'),
                //   ),
                //   FlatButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     child: Text('Ok'),
                //   ),
                // ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter Variety' : null,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: varietyNameController,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter No Of Plants' : null,
                  decoration: InputDecoration(
                      labelText: 'No Of Plants',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: varietyNoOfPlantsController,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    showDialogBox();
                    await postVariety(
                        widget.batchId,
                        varietyNameController.text,
                        varietyNoOfPlantsController.text);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    widget.navigateToListVarieties(widget.batchId);
                  },
                  child: Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.blue,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'Upload History',
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
