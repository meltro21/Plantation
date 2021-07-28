import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/models/dailyWork.dart';
import 'package:http/http.dart' as http;

Future<String> postDailyWork(
    String lightsCondition,
    oFansCondition,
    heatersCondition,
    eFansCondition,
    dehumidifierCondition,
    acCondition,
    tHigh,
    tLow,
    hHigh,
    hLow,
    feed,
    flush,
    gPlant,
    administrationPlant,
    fBuggySpray,
    fRinse,
    fFoodSpray,
    aSpray,
    bugs,
    waterORSoilTreatment,
    transplanting,
    topping,
    pruning,
    staking,
    cloning,
    harvest,
    cleaning,
    maintenance,
    construction,
    notes,
    uid) async {
  print('Fedd empty is: $feed');
  print(lightsCondition);
  double sum = 0.0;
  if (lightsCondition == '') {
    lightsCondition = "N/A";
  }
  if (oFansCondition == '') {
    oFansCondition = "N/A";
  }
  if (heatersCondition == '') {
    heatersCondition = "N/A";
  }
  if (eFansCondition == '') {
    eFansCondition = "N/A";
  }
  if (dehumidifierCondition == '') {
    dehumidifierCondition = "N/A";
  }
  if (acCondition == '') {
    acCondition = "N/A";
  }
  if (tHigh == '') {
    tHigh = "N/A";
  }
  if (tLow == '') {
    tLow = "N/A";
  }
  if (hHigh == '') {
    hHigh = "N/A";
  }
  if (hLow == '') {
    hLow = "N/A";
  }
  if (feed == '') {
    feed = "N/A";
  } else {
    sum = sum + double.parse(feed.toString());
    print("Fed sum is $sum");
  }
  if (flush == '') {
    flush = "N/A";
  } else {
    sum = sum + double.parse(flush.toString());
  }
  if (gPlant == '') {
    gPlant = "N/A";
  } else {
    sum = sum + double.parse(gPlant.toString());
  }
  if (administrationPlant == '') {
    administrationPlant = "N/A";
  } else {
    sum = sum + double.parse(administrationPlant.toString());
  }
  if (fBuggySpray == '') {
    fBuggySpray = "N/A";
  } else {
    sum = sum + double.parse(fBuggySpray.toString());
  }
  if (fRinse == '') {
    fRinse = "N/A";
  } else {
    sum = sum + double.parse(fRinse.toString());
  }
  if (fFoodSpray == '') {
    fFoodSpray = "N/A";
  } else {
    sum = sum + double.parse(fFoodSpray.toString());
  }
  if (aSpray == '') {
    aSpray = "N/A";
  } else {
    sum = sum + double.parse(aSpray.toString());
  }
  if (bugs == '') {
    bugs = "N/A";
  } else {
    sum = sum + double.parse(bugs.toString());
  }
  if (waterORSoilTreatment == '') {
    waterORSoilTreatment = "N/A";
  } else {
    sum = sum + double.parse(waterORSoilTreatment.toString());
  }
  if (transplanting == '') {
    transplanting = "N/A";
  } else {
    sum = sum + double.parse(transplanting.toString());
  }

  if (topping == '') {
    topping = "N/A";
  } else {
    sum = sum + double.parse(topping.toString());
  }
  if (pruning == '') {
    pruning = "N/A";
  } else {
    sum = sum + double.parse(pruning.toString());
  }
  if (staking == '') {
    staking = "N/A";
  } else {
    sum = sum + double.parse(staking.toString());
  }
  if (cloning == '') {
    cloning = "N/A";
  } else {
    sum = sum + double.parse(cloning.toString());
  }
  if (harvest == '') {
    harvest = "N/A";
  } else {
    sum = sum + double.parse(harvest.toString());
  }

  if (cleaning == '') {
    cleaning = "N/A";
  } else {
    sum = sum + double.parse(cleaning.toString());
  }
  if (maintenance == '') {
    maintenance = "N/A";
  } else {
    sum = sum + double.parse(maintenance.toString());
  }
  if (construction == '') {
    construction = "N/A";
  } else {
    sum = sum + double.parse(construction.toString());
  }
  if (notes == '') {
    notes = "N/A";
  }
  print("Sum is $sum");

  final response = await http.post(
      Uri.parse('https://hughplantation.herokuapp.com/dailyWork'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "LightsCondition": lightsCondition,
        "OFansCondition": oFansCondition,
        "HeatersCondition": heatersCondition,
        "EFansCondition": eFansCondition,
        "DehumidifierCondition": dehumidifierCondition,
        "AcCondition": acCondition,
        "THigh": tHigh,
        "TLow": tLow,
        "HHigh": hHigh,
        "HLow": hLow,
        "Feed": feed,
        "Flush": flush,
        "GPlant": gPlant,
        "AdministrationPlant": administrationPlant,
        "FBuggySpray": fBuggySpray,
        "FRinse": fRinse,
        "FFoodSpray": fFoodSpray,
        "ASpray": aSpray,
        "Bugs": bugs,
        "WaterORSoilTreatment": waterORSoilTreatment,
        "Transplanting": transplanting,
        "Topping": topping,
        "Pruning": pruning,
        "Staking": staking,
        "Cloning": cloning,
        "Harvest": harvest,
        "Cleaning": cleaning,
        "Maintenance": maintenance,
        "Construction": construction,
        "Notes": notes,
        "TotalHours": sum.toString(),
        "CreatedBy": uid
      }));

  if (response.statusCode == 200) {
    print(response.statusCode);
    print('Daily Work added successfully');
    return "success";
  } else {
    print('error adding batch');
    return "error";
  }
}

String lightsCondition = '';
String oFansCondition = '';
String heatersCondition = '';
String eFansCondition = '';
String dehumidifierCondition = '';
String acCondition = '';
TextEditingController tHighController = TextEditingController();
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

class DailyWorkEntry extends StatefulWidget {
  String uid;
  Function navigateToHomeDailyWorkEntry;
  DailyWorkEntry(this.uid, this.navigateToHomeDailyWorkEntry);
  @override
  _DailyWorkEntryState createState() => _DailyWorkEntryState();
}

class _DailyWorkEntryState extends State<DailyWorkEntry> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    lightsCondition = "";
    oFansCondition = "";
    heatersCondition = "";
    eFansCondition = "";
    dehumidifierCondition = "";
    acCondition = "";
    tHighController.text = '';
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
    notesController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Enter Daily Work'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DailyWorkFullForm(
              widget.uid, widget.navigateToHomeDailyWorkEntry),
        ),
      ),
    );
  }
}

class DailyWorkFullForm extends StatelessWidget {
  String uid;
  Function navigateToHomeDailyWorkEntry;
  DailyWorkFullForm(this.uid, this.navigateToHomeDailyWorkEntry);
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
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

    return Column(
      children: [
        Form(
          child: Column(
            children: [
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
                label: 'Heaters                 ',
                choice: heatersCondition,
              ),
              DailyWorkDropDown(
                label: 'Exaust Fans          ',
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
              DailyWorkForm(
                labelText: 'Temperatur High',
                tController: tHighController,
              ),
              DailyWorkForm(
                  labelText: 'Temperatur Low', tController: tLowController),
              DailyWorkForm(
                  labelText: 'Humadity High', tController: hHighController),
              DailyWorkForm(
                  labelText: 'Humadity Low', tController: hLowController),
              DailyWorkForm(
                labelText: 'Feed',
                tController: feedController,
              ),
              DailyWorkForm(
                labelText: 'Flush',
                tController: flushController,
              ),
              DailyWorkForm(
                labelText: 'General Plat Care',
                tController: gPlantCareController,
              ),
              DailyWorkForm(
                labelText: 'Administration, Solrting and or Moving Plants',
                tController: administrationPlantController,
              ),
              DailyWorkForm(
                labelText: 'Foliar Buggy Spray',
                tController: fBuggySprayController,
              ),
              DailyWorkForm(
                labelText: 'Foliar Rinse',
                tController: fRinseController,
              ),
              DailyWorkForm(
                labelText: 'Foliar Food Spray',
                tController: fFoodSprayController,
              ),
              DailyWorkForm(
                labelText: 'Alternate Spray',
                tController: aSprayController,
              ),
              DailyWorkForm(
                labelText: 'Bugs',
                tController: bugsController,
              ),
              DailyWorkForm(
                labelText: 'Water or Soil Bugg Treatment',
                tController: waterORSoilTreatmentController,
              ),
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
                labelText: 'Cloning',
                tController: cloningController,
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
                  print('Lights: $lightsCondition');
                  print(oFansCondition);
                  print(heatersCondition);

                  print(eFansCondition);
                  print(dehumidifierCondition);
                  print(acCondition);

                  print(tHighController.text);
                  print(tLowController.text);

                  print(hHighController.text);
                  print(hLowController.text);
                  print(feedController.text);
                  print(flushController.text);
                  print(gPlantCareController.text);
                  // print(tHighController.text);
                  // print(tHighController.text);
                  // print(tHighController.text);

                  showDialogBox();
                  await postDailyWork(
                      lightsCondition,
                      oFansCondition,
                      heatersCondition,
                      eFansCondition,
                      dehumidifierCondition,
                      acCondition,
                      tHighController.text,
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
                      uid);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  navigateToHomeDailyWorkEntry(uid);
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
                        'Upload Daily Work',
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
    if (label == "Temperatur High") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Temperatur Low") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Humadity High") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Humadity Low") {
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
    if (label == "General Plat Care") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Administration, Solrting and or Moving Plants") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Foliar Buggy Spray") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Foliar Rinse") {
      tHighController = t;
      temp = t;
      return temp;
    }

    if (label == "Foliar Food Spray") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Alternate Spray") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Bugs") {
      tHighController = t;
      temp = t;
      return temp;
    }
    if (label == "Water or Soil Bugg Treatment") {
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
          Text('${widget.label}'),
          Text('${widget.choice}'),
          DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            items: <String>['      Good', 'Problem'].map((String value) {
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
                } else if (widget.label == 'Exaust Fans          ') {
                  eFansCondition = _;
                } else if (widget.label == 'Dehumidifier         ') {
                  dehumidifierCondition = _;
                } else if (widget.label == 'AC                           ') {
                  acCondition = _;
                }
              });
            },
          ))
        ],
      ),
    );
  }
}
