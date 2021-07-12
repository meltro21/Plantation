import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AddVarietyProcessInfo extends StatelessWidget {
  String varietyId;
  AddVarietyProcessInfo(this.varietyId);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController aGradeController = TextEditingController();
    TextEditingController bGradeController = TextEditingController();
    TextEditingController shakeController = TextEditingController();
    TextEditingController compostController = TextEditingController();

    Future<String> postVarietyProcessInfo(
      String varietyId,
      String aGrade,
      String bGrade,
      String shake,
      String compost,
    ) async {
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

    void showDialogBox(String t, String s) {
      showCupertinoDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(t),
                content: Text(s),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ok'),
                  ),
                ],
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Batch'),
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
                      validator: (val) => val.isEmpty ? 'AGrade' : null,
                      decoration: InputDecoration(
                          labelText: 'AGrade',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: aGradeController,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'BGrade' : null,
                      decoration: InputDecoration(
                          labelText: 'BGrade',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: bGradeController,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Shake' : null,
                      decoration: InputDecoration(
                          labelText: 'Shake',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: shakeController,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Compost' : null,
                      decoration: InputDecoration(
                          labelText: 'Compost',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: compostController,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        postVarietyProcessInfo(
                          varietyId,
                          aGradeController.text,
                          bGradeController.text,
                          shakeController.text,
                          compostController.text,
                        );
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
                              'Add Variety Process Info',
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
