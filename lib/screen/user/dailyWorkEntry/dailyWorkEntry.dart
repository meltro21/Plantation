import 'package:flutter/material.dart';

class DailyWorkEntry extends StatefulWidget {
  @override
  _DailyWorkEntryState createState() => _DailyWorkEntryState();
}

class _DailyWorkEntryState extends State<DailyWorkEntry> {
  final _formKey = GlobalKey<FormState>();
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
  TextEditingController waterORSoilTreatmentController =
      TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Work Entry'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DailyWorkFullForm(
              tHighController: tHighController,
              tLowController: tLowController,
              hHighController: hHighController,
              hLowController: hLowController,
              lightsCondition: lightsCondition,
              oFansCondition: oFansCondition,
              heatersCondition: heatersCondition,
              eFansCondition: eFansCondition,
              dehumidifierCondition: dehumidifierCondition,
              acCondition: acCondition,
              feedController: feedController,
              flushController: flushController,
              gPlantCareController: gPlantCareController,
              administrationPlantController: administrationPlantController,
              fBuggySprayController: fBuggySprayController,
              fRinseController: fRinseController,
              fFoodSprayController: fFoodSprayController,
              aSprayController: aSprayController,
              bugsController: bugsController,
              waterORSoilTreatmentController: waterORSoilTreatmentController,
              transplantingController: transplantingController,
              toppingController: toppingController,
              pruningController: pruningController,
              stakingController: stakingController,
              cloningController: cloningController,
              harvestController: harvestController,
              cleaningController: cleaningController,
              maintenanceController: maintenanceController,
              constructionController: constructionController,
              notesController: notesController),
        ),
      ),
    );
  }
}

class DailyWorkFullForm extends StatelessWidget {
  const DailyWorkFullForm({
    Key key,
    @required this.tHighController,
    @required this.tLowController,
    @required this.hHighController,
    @required this.hLowController,
    @required this.lightsCondition,
    @required this.oFansCondition,
    @required this.heatersCondition,
    @required this.eFansCondition,
    @required this.dehumidifierCondition,
    @required this.acCondition,
    @required this.feedController,
    @required this.flushController,
    @required this.gPlantCareController,
    @required this.administrationPlantController,
    @required this.fBuggySprayController,
    @required this.fRinseController,
    @required this.fFoodSprayController,
    @required this.aSprayController,
    @required this.bugsController,
    @required this.waterORSoilTreatmentController,
    @required this.transplantingController,
    @required this.toppingController,
    @required this.pruningController,
    @required this.stakingController,
    @required this.cloningController,
    @required this.harvestController,
    @required this.cleaningController,
    @required this.maintenanceController,
    @required this.constructionController,
    @required this.notesController,
  }) : super(key: key);

  final TextEditingController tHighController;
  final TextEditingController tLowController;
  final TextEditingController hHighController;
  final TextEditingController hLowController;
  final String lightsCondition;
  final String oFansCondition;
  final String heatersCondition;
  final String eFansCondition;
  final String dehumidifierCondition;
  final String acCondition;
  final TextEditingController feedController;
  final TextEditingController flushController;
  final TextEditingController gPlantCareController;
  final TextEditingController administrationPlantController;
  final TextEditingController fBuggySprayController;
  final TextEditingController fRinseController;
  final TextEditingController fFoodSprayController;
  final TextEditingController aSprayController;
  final TextEditingController bugsController;
  final TextEditingController waterORSoilTreatmentController;
  final TextEditingController transplantingController;
  final TextEditingController toppingController;
  final TextEditingController pruningController;
  final TextEditingController stakingController;
  final TextEditingController cloningController;
  final TextEditingController harvestController;
  final TextEditingController cleaningController;
  final TextEditingController maintenanceController;
  final TextEditingController constructionController;
  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: Column(
            children: [
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
              )
            ],
          ),
        ),
        RaisedButton(onPressed: () {
          print('tHigh ${tHighController.text}');
          print('tLow ${tLowController.text}');
          print('hHigh ${hHighController.text}');
          print('hLow ${hLowController.text}');
          print('feed ${feedController.text}');

          print('flush ${flushController.text}');
          print('gPlant ${gPlantCareController.text}');
          print('admistritaion ${administrationPlantController.text}');
          print('fBuggy ${fBuggySprayController.text}');
          print('fRinse ${fRinseController.text}');
        })
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "$labelText",
      ),
      controller: tController,
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
              setState(() {
                widget.choice = _;
              });
            },
          ))
        ],
      ),
    );
  }
}
