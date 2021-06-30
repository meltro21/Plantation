import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GardenVariety extends StatefulWidget {
  @override
  _GardenVarietyState createState() => _GardenVarietyState();
}

class _GardenVarietyState extends State<GardenVariety> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController numOfPlantsController = TextEditingController();
  TextEditingController entryIntoRoomController = TextEditingController();
  TextEditingController exitFromRoomController = TextEditingController();

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
        exitFromRoomController.text = DateFormat.yMMMd().format(pickedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Varity Data'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter Batch #' : null,
                      decoration: InputDecoration(
                          labelText: 'Weight',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: weightController,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter Room Name' : null,
                      decoration: InputDecoration(
                          labelText: 'Number of Plants',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: numOfPlantsController,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Room Name' : null,
                            decoration: InputDecoration(
                                labelText: 'Entry into Room',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            controller: entryIntoRoomController,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pickStartDate();
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              child: Image.asset(
                                "littlePlant.png",
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Room Name' : null,
                            decoration: InputDecoration(
                                labelText: 'Exit from Room',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            controller: exitFromRoomController,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pickEndDate();
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              child: Image.asset(
                                "largePlant.png",
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
