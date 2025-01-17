// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
// import 'package:fluttertest/provider/batchProvider/varietyHistoryProvider.dart';
// import 'package:fluttertest/provider/batchProvider/varietyProvider.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// Future<String> postVarietyInfo(String varietyId, String roomName,
//     String noOfPlants, String entryIntoRoom) async {
//   print("In PostVariety");
//   final response =
//       await http.post(Uri.https('hughplantation.herokuapp.com', '/varietyInfo'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(<String, String>{
//             "VarietyId": varietyId,
//             "EnterRoomName": roomName,
//             "NoOfPlants": noOfPlants,
//             "EnterRoomDate": entryIntoRoom
//           }));
//   if (response.statusCode == 200) {
//     print('VarietyInfo added successfully');
//   }
// }

// class AddVarietyInfoUser extends StatefulWidget {


//   @override
//   _AddVarietyInfoUserState createState() => _AddVarietyInfoUserState();
// }

// class _AddVarietyInfoUserState extends State<AddVarietyInfoUser> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController roomNameController = TextEditingController();
//   TextEditingController noOfPlantsController = TextEditingController();
//   TextEditingController entryIntoRoomController = TextEditingController();
//   final spinkit = SpinKitChasingDots(
//     color: Colors.grey[200],
//     size: 50.0,
//   );

//   void pickStartDate() {
//     showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime.now(),
//             lastDate: DateTime.now().add(Duration(days: 1000)),
//             initialEntryMode: DatePickerEntryMode.input)
//         .then((pickedDate) {
//       if (pickedDate == null) {
//         print('No date Selected');
//       } else {
//         print('Selected Date is $pickedDate');
//         entryIntoRoomController.text = DateFormat.yMMMd().format(pickedDate);
//       }
//     });
//   }

//   void showDialogBox() {
//     showCupertinoDialog(
//         context: context,
//         builder: (_) => Container(
//               child: AlertDialog(
//                 content: Container(width: 50, height: 50, child: spinkit),
//               ),
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     final pBatch = Provider.of<BatchP>(context);
//     final pVariety = Provider.of<PVariety>(context);
//     final pVarietyHistory = Provider.of<PVarietyHistory>(context);

//         String batchNo = pBatch.lBatch[pBatch.currentBatchIndex].batchNo;
//     String varietyId =
//         pVariety.lVariety[pVariety.currentVarietyIndex].varietyId;

//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColorLight,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColorDark,
//         title: Text('Variety'),
//       ),
//       body: Container(
//         padding: EdgeInsets.only(left: 15, right: 15),
//         child: SingleChildScrollView(
//             child: Column(children: [
//           Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 TextFormField(
//                   validator: (val) => val.isEmpty ? 'Enter Room Name' : null,
//                   decoration: InputDecoration(
//                       labelText: 'Room',
//                       labelStyle: TextStyle(
//                           fontFamily: 'Montserrat',
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                       focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.green))),
//                   controller: roomNameController,
//                 ),
//                 TextFormField(
//                   validator: (val) => val.isEmpty ? 'Enter No Of Plants' : null,
//                   decoration: InputDecoration(
//                       labelText: 'No Of Plants',
//                       labelStyle: TextStyle(
//                           fontFamily: 'Montserrat',
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                       focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.green))),
//                   controller: noOfPlantsController,
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         validator: (val) =>
//                             val.isEmpty ? 'Entry into Room' : null,
//                         decoration: InputDecoration(
//                             labelText: 'Entry into Room',
//                             labelStyle: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.green))),
//                         controller: entryIntoRoomController,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         pickStartDate();
//                       },
//                       child: Container(
//                           height: 50,
//                           width: 50,
//                           child: Image.asset(
//                             "littlePlant.png",
//                             fit: BoxFit.fitWidth,
//                           )),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 GestureDetector(
//                   onTap: () async {
//                     if (_formKey.currentState.validate()) {
//                       showDialogBox();
//                       await pVarietyHistory.wrapperPostVarietyHistory(context, varietyId, roomNameController.text, stageController.text, noOfPlantsController.text, date)
//                       // await postVarietyInfo(
//                       //     widget.varietyId,
//                       //     roomNameController.text,
//                       //     noOfPlantsController.text,
//                       //     entryIntoRoomController.text);
//                       // Navigator.pop(context);
//                       // Navigator.pop(context);
//                       // Navigator.pop(context);
//                       // widget.navigateToVarietyInfoHome(widget.varietyId);
//                     }
//                   },
//                   child: Container(
//                     height: 40.0,
//                     child: Material(
//                       borderRadius: BorderRadius.circular(20.0),
//                       shadowColor: Colors.greenAccent,
//                       color: Theme.of(context).primaryColorDark,
//                       elevation: 7.0,
//                       child: Center(
//                         child: Text(
//                           'Add History',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Montserrat'),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ])),
//       ),
//     );
//   }
// }
