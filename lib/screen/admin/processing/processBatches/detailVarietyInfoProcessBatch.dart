import 'package:flutter/material.dart';
import 'package:fluttertest/models/varietyProcessModel.dart';

class DetailVarietyInfoProcessBatch extends StatefulWidget {
  VarietyProcessModel m;

  DetailVarietyInfoProcessBatch(this.m);

  @override
  _DetailVarietyInfoProcessBatchState createState() =>
      _DetailVarietyInfoProcessBatchState();
}

class _DetailVarietyInfoProcessBatchState
    extends State<DetailVarietyInfoProcessBatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('detail'),
      ),
      body: Container(
          child: Column(
        children: [
          Text('A Grade : ${widget.m.aGrade}'),
          Text('B Grade: ${widget.m.bGrade}'),
          Text('Shake : ${widget.m.shake}'),
          Text('Compost : ${widget.m.shake}'),
        ],
      )),
    );
  }
}
