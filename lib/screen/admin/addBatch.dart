import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AddBatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController batchNoController = TextEditingController();
    TextEditingController roomNameController = TextEditingController();
     TextEditingController entryIntoRoomController = TextEditingController();
     TextEditingController exitFromRoomController = TextEditingController();

    void pickStartDate()
    {
      showDatePicker(context: context,
      initialDate: DateTime.now(), 
     firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 1000)),
      initialEntryMode: DatePickerEntryMode.input).then((pickedDate){
        if(pickedDate==null)
        {
          print('No date Selected');
        }
        else
        {
          print('Selected Date is $pickedDate');
          entryIntoRoomController.text = DateFormat.yMMMd().format(pickedDate);
        }
      });
    }
    void pickEndDate()
    {
      showDatePicker(context: context,
      initialDate: DateTime.now(), 
     firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 1000)),
      initialEntryMode: DatePickerEntryMode.input).then((pickedDate){
        if(pickedDate==null)
        {
          print('No date Selected');
        }
        else
        {
          print('Selected Date is $pickedDate');
          exitFromRoomController.text = DateFormat.yMMMd().format(pickedDate);
        }
      });
    }
    void showDialogBox(String t,String s)
  {
    showCupertinoDialog(context: context, builder: (_)=>AlertDialog(
      title: Text(t),
      content: Text(s),
      actions: [
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('No'),
         ),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Ok'),
         ),],
    ));
  }
    return Scaffold(
      appBar: AppBar(title: Text('Add Batch'),),
      body: Container(
        padding: EdgeInsets.only(left:15,right:15),
        child: SingleChildScrollView(child: Column(
          children:[
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
                          SizedBox(height: 20.0),
                          TextFormField(
                            validator: (val) => val.isEmpty ? 'Enter Room Name': null,
                            decoration: InputDecoration(
                                labelText: 'Room Name',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                            controller: roomNameController,
                          ),
                            SizedBox(height: 20.0),
                            Row(children: [
                              Expanded(
                                    child: TextFormField(
                                  validator: (val) => val.isEmpty ? 'Enter Room Name': null,
                            decoration: InputDecoration(
                                  labelText: 'Entry into Room',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                            controller: entryIntoRoomController,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  pickStartDate();
                                },
                                child: Container(
                                height: 50,
                                width: 50,
                                child:Image.asset("littlePlant.png",
                                fit: BoxFit.fitWidth,)
                              ),
                              ),
                            ],),
                            SizedBox(height:20),
                             Row(children: [
                              Expanded(
                                    child: TextFormField(
                                  validator: (val) => val.isEmpty ? 'Enter Room Name': null,
                            decoration: InputDecoration(
                                  labelText: 'Exit from Room',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green))),
                            controller: exitFromRoomController,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  pickEndDate();
                                },
                                child: Container(
                                height: 50,
                                width: 50,
                                child:Image.asset("largePlant.png",
                                fit: BoxFit.fitWidth,)
                              ),
                              ),
                            ],),
                          // TextFormField(
                          //   validator: (val) => val.isEmpty ? 'Enter Phone Number': null,
                          //   decoration: InputDecoration(
                          //       labelText: 'Phone',
                          //       labelStyle: TextStyle(
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.grey),
                          //       focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(color: Colors.green))),
                          //   controller: phoneController,
                          // ),
                          // SizedBox(height: 20.0),
                          // TextFormField(
                          //   validator: (val) => val.isEmpty ? 'Enter Physical Address 1': null,
                          //   decoration: InputDecoration(
                          //       labelText: 'Physical Address 1',
                          //       labelStyle: TextStyle(
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.grey),
                          //       focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(color: Colors.green))),
                          //   controller: physicalAddress1Controller,
                          // ),

                          //  SizedBox(height: 20.0),
                          // TextFormField(
            
                          //   decoration: InputDecoration(
                          //       labelText: 'Physical Address 2',
                          //       labelStyle: TextStyle(
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.grey),
                          //       focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(color: Colors.green))),
                          //   controller: physicalAddress2Controller,
                          // ),
                          //  SizedBox(height: 20.0),
                          // TextFormField(
                          //   decoration: InputDecoration(
                          //       labelText: 'Physical City',
                          //       labelStyle: TextStyle(
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.grey),
                          //       focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(color: Colors.green))),
                          //   controller: physicalCityController,
                          // ),
                          //  SizedBox(height: 20.0),
                          // TextFormField(
                          //   decoration: InputDecoration(
                          //       labelText: 'Customer Region',
                          //       labelStyle: TextStyle(
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.grey),
                          //       focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(color: Colors.green))),
                          //   controller: customerRegionController,
                          // ),
                          //  SizedBox(height: 20.0),
                          // TextFormField(
                          //   decoration: InputDecoration(
                          //       labelText: 'Physical Post Code',
                          //       labelStyle: TextStyle(
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.grey),
                          //       focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(color: Colors.green))),
                          //   controller: physicalPostCodeController,
                          // ),
                          //  SizedBox(height: 20.0),
                          // TextFormField(
                          //   decoration: InputDecoration(
                          //       labelText: 'Delivery Method',
                          //       labelStyle: TextStyle(
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.grey),
                          //       focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(color: Colors.green))),
                          //   controller: deliveryMethodController,
                          // ),
                          
                          // SizedBox(height: 40.0),
                          // Container(
                          //   height: 40.0,
                          //   child: Material(
                          //     borderRadius: BorderRadius.circular(20.0),
                          //     shadowColor: Colors.greenAccent,
                          //     color: Colors.blue,
                          //     elevation: 7.0,
                          //     child: GestureDetector(
                          //       onTap: () async {
                                  
                          //         // print(emailController.text);
                          //         // print(passwordController.text);
                          //         if (_formKey.currentState.validate()) {
                          //           firestoreInstance.collection("Customers").add({
                          //             'Name':nameController.text,
                          //             'Email':emailController.text,
                          //             'Phone':phoneController.text,
                          //             'PhysicalAddress1':physicalAddress1Controller.text,
                          //             'PhysicalAddress2':physicalAddress2Controller.text,
                          //             'PhysicalCity':physicalCityController.text,
                          //             'CustomerRegion':customerRegionController.text,
                          //             'PhyscialPostCode':physicalPostCodeController.text,
                          //             'DeliveryMethod':deliveryMethodController.text,
                                      
                          //           }).then((value) { 
                          //                   print(value.id);
                          //                   // widget.addCustomersId(value.id);
                          //                   value.update({'CustomerUid':value.id});
                          //           });
                          //            Navigator.pop(context);
                          //           }
                          //       },
                          //       child: Center(
                          //         child: Text(
                          //           'Done',
                          //           style: TextStyle(
                          //               color: Colors.white,
                          //               fontWeight: FontWeight.bold,
                          //               fontFamily: 'Montserrat'),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),              
                        ],
                      ),
                    ),
                    SizedBox(height:20),
                     GestureDetector(
                        onTap: () async {
                               await FirebaseFirestore.instance.collection("Batches").add({
                                 'Batch#':batchNoController.text,
                                 "RoomName":roomNameController.text,
                                 "EntryIntoRoom":entryIntoRoomController.text,
                                 "ExitFromRoom":exitFromRoomController.text,
                                 "CreatedOn": DateTime.now().toString(),
                               }).then((value) {
                                 value.update({'BatchId':value.id});
                                 String title = "Added Successfully";
                                 String statement = "Congratulations, Batch is added Successfully";
                                 showDialogBox(title,statement);
                               
                               }).onError((error, stackTrace) {
                                  String title = "Error Occured";
                                 String statement = "Oops, Unable to add Batch $error";
                                 showDialogBox(title,statement);
                               });
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
        ),),
      ),
    );
  }
}