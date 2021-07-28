import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;

class AddVarietyProcessInfo extends StatelessWidget {
  String varietyId;
  Function navigateToVarietyHistoryList;
  AddVarietyProcessInfo(this.varietyId, this.navigateToVarietyHistoryList);
  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitChasingDots(
      color: Colors.grey[200],
      size: 50.0,
    );
    final _formKey = GlobalKey<FormState>();
    TextEditingController aGradeController = TextEditingController();
    TextEditingController bGradeController = TextEditingController();
    TextEditingController shakeController = TextEditingController();
    TextEditingController compostController = TextEditingController();
    TextEditingController totalHoursController = TextEditingController();
    TextEditingController noOfPlantsHarvestedController =
        TextEditingController();

    Future<String> postVarietyProcessInfo(
        String varietyId,
        String aGrade,
        String bGrade,
        String shake,
        String compost,
        String totalHours,
        String noOfPlantsHarvested) async {
      final response = await http.post(
          Uri.https('hughplantation.herokuapp.com', '/processingVariety'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "VarietyId": varietyId,
            "AGrade": aGrade,
            "BGrade": bGrade,
            "Shake": shake,
            "Compost": compost,
            "NoOfPlantsHarvested": noOfPlantsHarvested,
            "TotalHours": totalHours
          }));

      if (response.statusCode == 200) {
        print('varietyProcessInfo successfully');
      } else {
        print('varietyProcessInfo Error');
      }
    }

    void pickStartDate() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 1000)),
              initialEntryMode: DatePickerEntryMode.input)
          .then((pickedDate) {
        if (pickedDate == null) {
          print('No date Selected');
        } else {
          print('Selected Date is $pickedDate');
          // entryIntoRoomController.text = DateFormat.yMMMd().format(pickedDate);
        }
      });
    }

    void pickEndDate() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 1000)),
              initialEntryMode: DatePickerEntryMode.input)
          .then((pickedDate) {
        if (pickedDate == null) {
          print('No date Selected');
        } else {
          print('Selected Date is $pickedDate');
          // harvestDateController.text = DateFormat.yMMMd().format(pickedDate);
        }
      });
    }

    void showDialogBox() {
      showCupertinoDialog(
          context: context,
          builder: (_) => Container(
                child: AlertDialog(
                  content: Container(width: 50, height: 50, child: spinkit),
                ),
              ));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Add Weight'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty ? 'Enter AGrade' : null,
                      decoration: InputDecoration(
                          labelText: 'AGrade',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: aGradeController,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty ? 'Enter BGrade' : null,
                      decoration: InputDecoration(
                          labelText: 'BGrade',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: bGradeController,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty ? 'Enter Shake' : null,
                      decoration: InputDecoration(
                          labelText: 'Shake',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: shakeController,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty ? 'Enter Compost' : null,
                      decoration: InputDecoration(
                          labelText: 'Compost',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: compostController,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val.isEmpty ? 'Enter No Of Plants Harvested' : null,
                      decoration: InputDecoration(
                          labelText: 'No Of Plants Harvested',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: noOfPlantsHarvestedController,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val.isEmpty ? 'Enter Total Hours' : null,
                      decoration: InputDecoration(
                          labelText: 'Total Hours',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: totalHoursController,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          showDialogBox();
                          await postVarietyProcessInfo(
                              varietyId,
                              aGradeController.text,
                              bGradeController.text,
                              shakeController.text,
                              compostController.text,
                              totalHoursController.text,
                              noOfPlantsHarvestedController.text);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          this.navigateToVarietyHistoryList(varietyId);
                        }
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
                              'Add Weight',
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
            ],
          ),
        ),
      ),
    );
  }
}
