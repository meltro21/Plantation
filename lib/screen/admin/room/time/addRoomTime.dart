import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/room/timeProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

DateTime dTime = DateTime.now();
int hours = dTime.hour;
int min = dTime.minute;
int sec = dTime.second;
int msec = dTime.millisecond;
int micros = dTime.microsecond;
DateTime endDate = dTime.subtract(Duration(
    hours: hours,
    minutes: min,
    seconds: sec,
    milliseconds: msec,
    microseconds: micros));
String eeDate = endDate.toString();

class AddRoomTime extends StatefulWidget {
  String roomId;
  AddRoomTime(this.roomId);
  @override
  _AddRoomTimeState createState() => _AddRoomTimeState();
}

class _AddRoomTimeState extends State<AddRoomTime> {
  TextEditingController batchNoController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  // String endDate;

  String date = DateFormat.yMMMd().format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );
  String batchNo = '';

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
        //endDateController.text = DateFormat.yMMMd().format(pickedDate);
        endDateController.text = pickedDate.toString();
        FocusScope.of(context).requestFocus(FocusNode());

        // setState(() {
        //   date = DateFormat.yMMMd().format(pickedDate);
        // });
      }
    });
  }

  void smallLoading() {
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
    final pRoomTime = Provider.of<PRoomTime>(context);
    final pBatch = Provider.of<BatchP>(context);
    List<String> batches = [];
    for (int i = 0; i < pBatch.lBatch.length; i++) {
      batches.add(pBatch.lBatch[i].batchNo);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Add Time'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                // TextFormField(
                //   validator: (val) => val.isEmpty ? 'Batch #' : null,
                //   decoration: InputDecoration(
                //       labelText: 'Batch #',
                //       labelStyle: TextStyle(
                //           fontFamily: 'Montserrat',
                //           fontWeight: FontWeight.bold,
                //           color: Colors.black),
                //       focusedBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(color: Colors.green))),
                //   controller: batchNoController,
                // ),
                Container(
                  child: Row(
                    children: [
                      Container(width: 100, child: Text('Batch #')),
                      SizedBox(
                        width: 20,
                      ),

                      Expanded(
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter Batch #' : null,
                          readOnly: true,
                          controller: batchNoController,
                        ),
                      ),

                      // Container(width: 60, child: Text('$room')),
                      Expanded(
                        child: Container(
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                            items: batches.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                batchNo = _;
                                batchNoController.text = _;
                              });
                            },
                          )),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    // Expanded(
                    //     child: Text(
                    //   '${date.toString()}',
                    //   style: TextStyle(decoration: TextDecoration.underline),
                    // )),
                    Container(width: 100, child: Text('Date')),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (val) => val.isEmpty ? 'Enter Date' : null,
                        readOnly: true,
                        controller: endDateController,
                      ),
                    ),

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
                      smallLoading();
                      await pRoomTime.wrapperPostRoomTime(
                        context,
                        widget.roomId,
                        endDateController.text,
                        batchNoController.text,
                      );
                      pRoomTime.wrapperGetRoomTime(context, widget.roomId);
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
                          'Upload End Time',
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
            )),
      ),
    );
  }
}
