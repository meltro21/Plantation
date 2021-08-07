import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/batchProvider.dart';
import 'package:fluttertest/provider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/varietyProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class addVarietyInfoAdmin extends StatefulWidget {
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
    final pBatch = Provider.of<BatchP>(context);
    final pVariety = Provider.of<PVariety>(context);
    final pVarietyHistory = Provider.of<PVarietyHistory>(context);

    String batchNo = pBatch.lBatch[pBatch.index].batchNo;
    String varietyId = pVariety.lVariety[pVariety.index].varietyId;

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
                        child: Text(
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
                    await pVarietyHistory.wrapperPostVarietyHistory(
                        context,
                        varietyId,
                        roomNameController.text,
                        stageController.text,
                        noOfPlantsController.text,
                        date);
                    pVariety.wrapperGetVarieties(
                        context, pBatch.lBatch[pBatch.index].id);
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
