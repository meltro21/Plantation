import 'package:flutter/material.dart';

class ErrorOccured extends StatefulWidget {
  String err;
  ErrorOccured(err);

  @override
  _ErrorOccuredState createState() => _ErrorOccuredState();
}

class _ErrorOccuredState extends State<ErrorOccured> {
  @override
  Widget build(BuildContext context) {
    if (widget.err == '') {
      widget.err = "Unable to Load";
    }
    return Scaffold(
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 200,
            width: 200,
            child: Column(
              children: [
                Text(
                  'Oops!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(widget.err),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
