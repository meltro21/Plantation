import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

Future<String> postBatch(
    String batchNo,
    String enterRoomName,
    String entryRoomDate,
    String noOfPlantsHarvested,
    String harvestDate) async {
  final response =
      await http.post(Uri.https('hughplantation.herokuapp.com', '/batches'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "BatchNo": batchNo,
            "EnterRoomName": enterRoomName,
            "EnterRoomDate": entryRoomDate,
            "NoOfPlantsHarvested": noOfPlantsHarvested,
            "HarvestDate": harvestDate
          }));

  if (response.statusCode == 200) {
    print('batch added successfully');
  } else {
    print('error adding batch');
  }
}

class AddBatch extends StatelessWidget {
  Function navigateToAdminBatches;
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );
  AddBatch(this.navigateToAdminBatches);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController batchNoController = TextEditingController();
    TextEditingController roomNameController = TextEditingController();
    TextEditingController noOfPlantsHarvestedController =
        TextEditingController();
    TextEditingController entryIntoRoomController = TextEditingController();
    TextEditingController harvestDateController = TextEditingController();

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
          entryIntoRoomController.text = DateFormat.yMMMd().format(pickedDate);
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
          harvestDateController.text = DateFormat.yMMMd().format(pickedDate);
        }
      });
    }

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
                      validator: (val) => val.isEmpty ? 'Enter Batch #' : null,
                      decoration: InputDecoration(
                          labelText: 'Batch #',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: batchNoController,
                    ),
                    // SizedBox(height: 20.0),
                    // TextFormField(
                    //   validator: (val) =>
                    //       val.isEmpty ? 'Enter Room Name' : null,
                    //   decoration: InputDecoration(
                    //       labelText: 'Room Name',
                    //       labelStyle: TextStyle(
                    //           fontFamily: 'Montserrat',
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.grey),
                    //       focusedBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.green))),
                    //   controller: roomNameController,
                    // ),
                    // SizedBox(height: 20.0),
                    // TextFormField(
                    //   validator: (val) => val.isEmpty ? 'Enter Batch #' : null,
                    //   decoration: InputDecoration(
                    //       labelText: 'No Of Plants Harvested',
                    //       labelStyle: TextStyle(
                    //           fontFamily: 'Montserrat',
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.grey),
                    //       focusedBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.green))),
                    //   controller: noOfPlantsHarvestedController,
                    // ),
                    // SizedBox(height: 20.0),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: TextFormField(
                    //         validator: (val) =>
                    //             val.isEmpty ? 'Enter Room Name' : null,
                    //         decoration: InputDecoration(
                    //             labelText: 'Entry into Room',
                    //             labelStyle: TextStyle(
                    //                 fontFamily: 'Montserrat',
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.grey),
                    //             focusedBorder: UnderlineInputBorder(
                    //                 borderSide:
                    //                     BorderSide(color: Colors.green))),
                    //         controller: entryIntoRoomController,
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         pickStartDate();
                    //       },
                    //       child: Container(
                    //           height: 50,
                    //           width: 50,
                    //           child: Image.asset(
                    //             "littlePlant.png",
                    //             fit: BoxFit.fitWidth,
                    //           )),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: TextFormField(
                    //         validator: (val) =>
                    //             val.isEmpty ? 'Enter Room Name' : null,
                    //         decoration: InputDecoration(
                    //             labelText: 'Harvest Date',
                    //             labelStyle: TextStyle(
                    //                 fontFamily: 'Montserrat',
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.grey),
                    //             focusedBorder: UnderlineInputBorder(
                    //                 borderSide:
                    //                     BorderSide(color: Colors.green))),
                    //         controller: harvestDateController,
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         pickEndDate();
                    //       },
                    //       child: Container(
                    //           height: 50,
                    //           width: 50,
                    //           child: Image.asset(
                    //             "largePlant.png",
                    //             fit: BoxFit.fitWidth,
                    //           )),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  showDialogBox();
                  await postBatch(
                      batchNoController.text,
                      roomNameController.text,
                      noOfPlantsHarvestedController.text,
                      entryIntoRoomController.text,
                      harvestDateController.text);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  navigateToAdminBatches();
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
                        'Create Batch',
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
      ),
    );
  }
}
