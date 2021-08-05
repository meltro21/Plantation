import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<String> postVarietyInfo(String varietyId, String roomName, String stage,
    String noOfPlants, String entryIntoRoom) async {
  print("In PostVariety");
  final response =
      await http.post(Uri.https('hughplantation.herokuapp.com', '/varietyInfo'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "VarietyId": varietyId,
            "EnterRoomName": roomName,
            "Stage": stage,
            "NoOfPlants": noOfPlants,
            "EnterRoomDate": entryIntoRoom
          }));
  if (response.statusCode == 200) {
    print('VarietyInfo added successfully');
  }
}

class addVarietyInfoAdmin extends StatefulWidget {
  String varietyId;
  String batchNo;
  Function navigateToVarietyInfoHome;
  addVarietyInfoAdmin(
      this.varietyId, this.batchNo, this.navigateToVarietyInfoHome);

  @override
  _addVarietyInfoAdminState createState() => _addVarietyInfoAdminState();
}

class _addVarietyInfoAdminState extends State<addVarietyInfoAdmin> {
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );
  final _formKey = GlobalKey<FormState>();
  String date = DateFormat.yMMMd().format(DateTime.now());
  TextEditingController roomNameController = TextEditingController();
  TextEditingController stageController = TextEditingController();
  TextEditingController noOfPlantsController = TextEditingController();
  TextEditingController entryIntoRoomController = TextEditingController();

  void pickStartDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 1000)),
            initialEntryMode: DatePickerEntryMode.calendarOnly)
        .then((pickedDate) {
      if (pickedDate == null) {
        print('No date Selected');
      } else {
        print('Selected Date is $pickedDate');
        entryIntoRoomController.text = DateFormat.yMMMd().format(pickedDate);
        setState(() {
          date = DateFormat.yMMMd().format(pickedDate);
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Variety History'),
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
                  validator: (val) => val.isEmpty ? 'Room' : null,
                  decoration: InputDecoration(
                      labelText: 'Room',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: roomNameController,
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Stage' : null,
                  decoration: InputDecoration(
                      labelText: 'Stage',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: stageController,
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter No Of Plants' : null,
                  decoration: InputDecoration(
                      labelText: 'No Of Plants',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: noOfPlantsController,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child:
                            // TextFormField(
                            //   validator: (val) =>
                            //       val.isEmpty ? 'Enter Room Name' : null,
                            //   decoration: InputDecoration(
                            //       labelText: 'Entry into Room',
                            //       labelStyle: TextStyle(
                            //           fontFamily: 'Montserrat',
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.black),
                            //       focusedBorder: UnderlineInputBorder(
                            //           borderSide: BorderSide(color: Colors.green)
                            // )),
                            //   controller: entryIntoRoomController,
                            // ),
                            Text(
                      '${date.toString()}',
                      style: TextStyle(decoration: TextDecoration.underline),
                    )),
                    GestureDetector(
                      onTap: () {
                        pickStartDate();
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          child: Icon(Icons.calendar_today_rounded)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    showDialogBox();
                    await postVarietyInfo(
                        widget.varietyId,
                        roomNameController.text,
                        stageController.text,
                        noOfPlantsController.text,
                        date);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    widget.navigateToVarietyInfoHome(
                        widget.varietyId, widget.batchNo);
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
