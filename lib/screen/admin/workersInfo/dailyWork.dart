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
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Select Worker'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: widget.workers.length,
            itemBuilder: (context, index) {
              return Card(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(
                    widget.workers[index].userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IndividualDailyWork(
                                widget.workers[index].firestoreId)));
                  },
                ),
              );
            }),
      ),
    );
  }
}
