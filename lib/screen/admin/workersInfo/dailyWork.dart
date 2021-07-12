import 'package:flutter/material.dart';
import 'package:fluttertest/models/workers.dart';
import 'package:fluttertest/screen/admin/workersInfo/individualDailyWork.dart';

class DailyWorkHome extends StatefulWidget {
  List<WorkerModel> workers;
  DailyWorkHome(this.workers);
  @override
  _DailyWorkHomeState createState() => _DailyWorkHomeState();
}

class _DailyWorkHomeState extends State<DailyWorkHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Worker'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: widget.workers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.workers[index].userName),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IndividualDailyWork(
                              widget.workers[index].firestoreId)));
                },
              );
            }),
      ),
    );
  }
}
