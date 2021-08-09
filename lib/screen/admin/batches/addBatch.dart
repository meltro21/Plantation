import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddBatch extends StatelessWidget {
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    final pBatch = Provider.of<BatchP>(context);

    final _formKey = GlobalKey<FormState>();
    TextEditingController batchNoController = TextEditingController();

    void smallLoading() {
      showCupertinoDialog(
          context: context,
          builder: (_) => Container(
                child: AlertDialog(
                  content: Container(width: 50, height: 50, child: spinkit),
                ),
              ));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Add Batch'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: batchNoController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    smallLoading();
                    await pBatch.wrapperPostBatch(
                        context, batchNoController.text);
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
          ),
        ),
      ),
    );
  }
}
