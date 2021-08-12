import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
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
  String room = '';
  final _formKey = GlobalKey<FormState>();
  String date = DateFormat.yMMMd().format(DateTime.now());
  //TextEditingController roomNameController = TextEditingController();
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
    final pRoom = Provider.of<PRoom>(context);

    String batchNo = pBatch.lBatch[pBatch.currentBatchIndex].batchNo;
    String varietyId =
        pVariety.lVariety[pVariety.currentVarietyIndex].varietyId;
    List<String> rooms = [];
    for (int i = 0; i < pRoom.lRoom.length; i++) {
      rooms.add(pRoom.lRoom[i].name);
    }

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
                Row(
                  children: [
                    Container(
                        width: 100,
                        child: Text(
                          'Room',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(width: 60, child: Text('$room')),
                    Container(
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        items: rooms.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            room = _;
                          });
                        },
                      )),
                    )
                  ],
                ),
                // TextFormField(
                //   validator: (val) => val.isEmpty ? 'Room' : null,
                //   decoration: InputDecoration(
                //       labelText: 'Room',
                //       labelStyle: TextStyle(
                //           fontFamily: 'Montserrat',
                //           fontWeight: FontWeight.bold,
                //           color: Colors.black),
                //       focusedBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(color: Colors.green))),
                //   controller: roomNameController,
                // ),
                // SizedBox(height: 20),
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
                    if (_formKey.currentState.validate()) {
                      showDialogBox();
                      await pVarietyHistory.wrapperPostVarietyHistory(
                          context,
                          varietyId,
                          room,
                          stageController.text,
                          noOfPlantsController.text,
                          date);
                      pVariety.wrapperGetVarieties(
                          context, pBatch.lBatch[pBatch.currentBatchIndex].id);
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.pop(context);
                      Navigator.pop(context);
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
