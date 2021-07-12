import 'package:flutter/material.dart';
import 'package:fluttertest/screen/admin/processing/batchesHistory/batchesHIstory.dart';
import 'package:fluttertest/screen/admin/processing/processBatches/batchesListProcessBatches.dart';

class HomeProcessing extends StatefulWidget {
  const HomeProcessing({Key key}) : super(key: key);

  @override
  _HomeProcessingState createState() => _HomeProcessingState();
}

class _HomeProcessingState extends State<HomeProcessing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Card(
                elevation: 5,
                child: Container(
                    height: 150,
                    width: 150,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BatchesListProcessBatches()));
                      },
                      child: Align(
                          alignment: Alignment.center,
                          child: Text('Process Batches')),
                    ))),
            Card(
                elevation: 5,
                child: Container(
                    height: 150,
                    width: 150,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BatchesHistory()));
                      },
                      child: Align(
                          alignment: Alignment.center,
                          child: Text('Batches History')),
                    ))),
          ],
        ),
      ),
    );
  }
}
