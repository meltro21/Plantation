import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/dailyWork/dailyWorkProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

String room = '';
String lightsCondition = 'Good';
String oFansCondition = 'Good';
String heatersCondition = 'Good';
String eFansCondition = 'Good';
String dehumidifierCondition = 'Good';
String acCondition = 'Good';
TextEditingController roomController = TextEditingController();
TextEditingController tHighController = TextEditingController();
TextEditingController ttHighController = TextEditingController();
TextEditingController tLowController = TextEditingController();
TextEditingController hHighController = TextEditingController();
TextEditingController hLowController = TextEditingController();
TextEditingController feedController = TextEditingController();
TextEditingController flushController = TextEditingController();
TextEditingController gPlantCareController = TextEditingController();
TextEditingController administrationPlantController = TextEditingController();
TextEditingController fBuggySprayController = TextEditingController();
TextEditingController fRinseController = TextEditingController();
TextEditingController fFoodSprayController = TextEditingController();
TextEditingController aSprayController = TextEditingController();
TextEditingController bugsController = TextEditingController();
TextEditingController waterORSoilTreatmentController = TextEditingController();
TextEditingController transplantingController = TextEditingController();
TextEditingController toppingController = TextEditingController();
TextEditingController pruningController = TextEditingController();
TextEditingController stakingController = TextEditingController();
TextEditingController cloningController = TextEditingController();
TextEditingController harvestController = TextEditingController();
TextEditingController cleaningController = TextEditingController();
TextEditingController maintenanceController = TextEditingController();
TextEditingController constructionController = TextEditingController();

TextEditingController notesController = TextEditingController();
List<String> rooms = [];
final _formKey = GlobalKey<FormState>();

class DailyWorkEntry extends StatefulWidget {
  String uid;
  DailyWorkEntry(
    this.uid,
  );
  @override
  _DailyWorkEntryState createState() => _DailyWorkEntryState();
}

class _DailyWorkEntryState extends State<DailyWorkEntry> {
  @override
  void dispose() {
    room = " ";
    roomController.text = '';
    lightsCondition = "Good";
    oFansCondition = "Good";
    heatersCondition = "Good";
    eFansCondition = "Good";
    dehumidifierCondition = "Good";
    acCondition = "Good";
    tHighController.text = '';
    ttHighController.text = '';
    tLowController.text = '';
    hHighController.text = '';
    hLowController.text = '';
    feedController.text = '';
    flushController.text = '';
    gPlantCareController.text = '';
    administrationPlantController.text = '';
    fBuggySprayController.text = '';
    fRinseController.text = '';
    fFoodSprayController.text = '';
    aSprayController.text = '';
    bugsController.text = '';
    waterORSoilTreatmentController.text = '';
    transplantingController.text = '';
    pruningController.text = '';
    stakingController.text = '';
    cloningController.text = '';
    harvestController.text = '';
    cleaningController.text = '';
    maintenanceController.text = '';
    constructionController.text = '';
    toppingController.text = '';
    notesController.text = '';
    rooms.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pRoom = Provider.of<PRoom>(context);
    final pDailyWork = Provider.of<PDailyWork>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Enter Daily Work'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DailyWorkFullForm(widget.uid, null),
        ),
      ),
    );
  }
}

class DailyWorkFullForm extends StatefulWidget {
  String uid;
  Function navigateToHomeDailyWorkEntry;
  DailyWorkFullForm(this.uid, this.navigateToHomeDailyWorkEntry);

  @override
  _DailyWorkFullFormState createState() => _DailyWorkFullFormState();
}

class _DailyWorkFullFormState extends State<DailyWorkFullForm> {
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    final pRoom = Provider.of<PRoom>(context);
    final pDailyWork = Provider.of<PDailyWork>(context);
    List<String> rooms = [];
    for (int i = 0; i < pRoom.lRoom.length; i++) {
      rooms.add(pRoom.lRoom[i].name);
    }
    //rooms = pRoom.getRoomName();
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

    return pRoom.loading
        ? Container(
            child: Loading(),
          )
        : Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Room & Equipment',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        Container(
                          child: Row(
                            children: [
                              Container(width: 100, child: Text('Room')),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 60,
                                child: TextFormField(
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter Room' : null,
                                  readOnly: true,
                                  controller: roomController,
                                ),
                              ),
                              // Container(width: 60, child: Text('$room')),
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
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      room = _;
                                      roomController.text = _;
                                    });
                                  },
                                )),
                              )
                            ],
                          ),
                        ),
                        DailyWorkDropDown(
                          label: 'Lights:                  ',
                          choice: lightsCondition,
                          width: 60,
                        ),
                        DailyWorkDropDown(
                          label: 'Oscillating Fans: ',
                          choice: oFansCondition,
                          width: 0,
                        ),
                        DailyWorkDropDown(
                          label: 'Heaters                  ',
                          choice: heatersCondition,
                        ),
                        DailyWorkDropDown(
                          label: 'Exhaust Fans          ',
                          choice: eFansCondition,
                        ),
                        DailyWorkDropDown(
                          label: 'Dehumidifier         ',
                          choice: dehumidifierCondition,
                        ),
                        DailyWorkDropDown(
                          label: 'AC                           ',
                          choice: acCondition,
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'General',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),

                    // DailyWorkForm(
                    //   labelText: 'Temperatur High',
                    //   tController: tHighController,
                    // ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Temperature High",
                      ),
                      controller: ttHighController,
                    ),
                    DailyWorkForm(
                        labelText: 'Temperature Low',
                        tController: tLowController),
                    DailyWorkForm(
                        labelText: 'Humidity High',
                        tController: hHighController),
                    DailyWorkForm(
                        labelText: 'Humidity Low', tController: hLowController),
                    DailyWorkForm(
                      labelText: 'Feed',
                      tController: feedController,
                    ),
                    DailyWorkForm(
                      labelText: 'Flush',
                      tController: flushController,
                    ),
                    DailyWorkForm(
                      labelText: 'Foliar Bug Spray',
                      tController: fBuggySprayController,
                    ),
                    DailyWorkForm(
                      labelText: 'Foliar Mold Spray',
                      tController: aSprayController,
                    ),
                    DailyWorkForm(
                      labelText: 'Foliar Rinse Spray',
                      tController: fRinseController,
                    ),
                    DailyWorkForm(
                      labelText: 'Foliar Food Spray',
                      tController: fFoodSprayController,
                    ),
                    DailyWorkForm(
                      labelText: 'Bugs',
                      tController: bugsController,
                    ),
                    DailyWorkForm(
                      labelText: 'Water or Soil Bug Treatment',
                      tController: waterORSoilTreatmentController,
                    ),

                    DailyWorkForm(
                      labelText: 'Plant Sorting',
                      tController: administrationPlantController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Hours',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    DailyWorkForm(
                      labelText: 'General Plant Care',
                      tController: gPlantCareController,
                    ),
                    DailyWorkForm(
                      labelText: 'Cloning',
                      tController: cloningController,
                    ),
                    //ToDo check if there is this field

                    DailyWorkForm(
                      labelText: 'Transplanting',
                      tController: transplantingController,
                    ),
                    DailyWorkForm(
                      labelText: 'Topping',
                      tController: toppingController,
                    ),
                    DailyWorkForm(
                      labelText: 'Pruning',
                      tController: pruningController,
                    ),
                    DailyWorkForm(
                      labelText: 'Staking',
                      tController: stakingController,
                    ),

                    DailyWorkForm(
                      labelText: 'Harvest',
                      tController: harvestController,
                    ),
                    DailyWorkForm(
                      labelText: 'Cleaning',
                      tController: cleaningController,
                    ),
                    DailyWorkForm(
                      labelText: 'Maintenance',
                      tController: maintenanceController,
                    ),
                    DailyWorkForm(
                      labelText: 'Contruction',
                      tController: constructionController,
                    ),
                    DailyWorkForm(
                      labelText: 'NOTES:',
                      tController: notesController,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        print("Add batch post called");
                        print("Parameters are: ");
                        print("Thigh: ${ttHighController.text}");
                        //print("Thigh: ${tHighController.text}");
                        print("TLow: ${tLowController.text}");
                        print("construction: ${constructionController.text}");
                        print("notes: ${notesController.text}");
                        print(tHighController.text);
                        print(tHighController.text);
                        print(tHighController.text);

                        print('controller ${roomController.text}');
                        if (_formKey.currentState.validate()) {
                          showDialogBox();
                          await pDailyWork.wrapperPostDailyWork(
                              context,
                              pDailyWork.dailyWorkUid,
                              lightsCondition,
                              oFansCondition,
                              heatersCondition,
                              eFansCondition,
                              dehumidifierCondition,
                              acCondition,
                              ttHighController.text,
                              tLowController.text,
                              hHighController.text,
                              hLowController.text,
                              feedController.text,
                              flushController.text,
                              gPlantCareController.text,
                              administrationPlantController.text,
                              fBuggySprayController.text,
                              fRinseController.text,
                              fFoodSprayController.text,
                              aSprayController.text,
                              bugsController.text,
                              waterORSoilTreatmentController.text,
                              transplantingController.text,
                              toppingController.text,
                              pruningController.text,
                              stakingController.text,
                              cloningController.text,
                              harvestController.text,
                              cleaningController.text,
                              maintenanceController.text,
                              constructionController.text,
                              notesController.text,
                              widget.uid,
                              roomController.text);
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Theme.of(context).primaryColorDark,
                          elevation: 7.0,
                          child: Center(
                            child: Text(
                              'Enter Daily Work',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
  }
}

class DailyWorkForm extends StatelessWidget {
  // const DailyWorkForm({
  //   Key key,

  // }) : super(key: key);
  String labelText;
  TextEditingController tController;

  DailyWorkForm({this.labelText, this.tController});

  TextEditingController editingController(
      String label, TextEditingController t) {
    TextEditingController temp = TextEditingController();
    if (label == "Temperature High") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Temperature Low") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Humidity High") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Humidity Low") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Feed") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Flush") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "General Plant Care") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Plant Sorting") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Foliar Bug Spray") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Foliar Rinse Spray") {
      tHighController = t;
      temp = t;
      return temp;
    }

    if (label == "Foliar Food Spray") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Foliar Mold Spray") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Bugs") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Water or Soil Bug Treatment") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Transplanting") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Topping") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Pruning") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Staking") {
      tHighController = t;
      temp = t;
      return temp;
    }

    if (label == "Cloning") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Harvest") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Cleaning") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Maintenance") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Contruction") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "NOTES:") {
      notesController = t;
      temp = t;
      return temp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "$labelText",
      ),
      controller: editingController(labelText, tController),
    );
  }
}

class DailyWorkDropDown extends StatefulWidget {
  String label;
  String choice;
  double width;
  DailyWorkDropDown({this.label, this.choice, this.width});
  @override
  _DailyWorkDropDownState createState() => _DailyWorkDropDownState();
}

class _DailyWorkDropDownState extends State<DailyWorkDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(width: 100, child: Text('${widget.label}')),
          SizedBox(
            width: 20,
          ),
          Container(
              width: 60, child: Container(child: Text('${widget.choice}'))),
          Container(
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
              items: <String>['Good', 'Problem'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {
                // if (widget.label == 'Lights:                  ') {
                //   print('In Lights');
                //   lightsCondition = _;
                //   print(lightsCondition);
                // }
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  widget.choice = _;
                  if (widget.label == 'Lights:                  ') {
                    print('In Lights');
                    lightsCondition = _;
                    print(lightsCondition);
                  }
                  if (widget.label == 'Oscillating Fans: ') {
                    print('In oFans');
                    oFansCondition = _;
                    print(lightsCondition);
                  }
                  if (widget.label == 'Heaters                 ') {
                    print('In oFans');
                    heatersCondition = _;
                    print(lightsCondition);
                  } else if (widget.label == 'Exhaust Fans          ') {
                    eFansCondition = _;
                  } else if (widget.label == 'Dehumidifier         ') {
                    dehumidifierCondition = _;
                  } else if (widget.label == 'AC                           ') {
                    acCondition = _;
                  }
                });
              },
            )),
          )
        ],
      ),
    );
  }
}
