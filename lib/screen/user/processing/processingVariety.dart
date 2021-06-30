import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProcessingVariety extends StatefulWidget {
  @override
  _ProcessingVarietyState createState() => _ProcessingVarietyState();
}

class _ProcessingVarietyState extends State<ProcessingVariety> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController aGradeController = TextEditingController();
  TextEditingController bGradeController = TextEditingController();
  TextEditingController shakeController = TextEditingController();
  TextEditingController compostController = TextEditingController();
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
                          labelText: 'A Grade',
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
                      validator: (val) =>
                          val.isEmpty ? 'Enter Room Name' : null,
                      decoration: InputDecoration(
                          labelText: 'B Grade',
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
                      validator: (val) =>
                          val.isEmpty ? 'Enter Room Name' : null,
                      decoration: InputDecoration(
                          labelText: 'Shake',
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
                      validator: (val) =>
                          val.isEmpty ? 'Enter Room Name' : null,
                      decoration: InputDecoration(
                          labelText: 'Compost',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: bGradeController,
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
