import 'package:flutter/material.dart';
import 'package:fluttertest/screen/user/dailyWorkEntry/dailyWorkEntry.dart';
import 'package:fluttertest/screen/user/gardenHistory/gardenHistory.dart';
import 'package:fluttertest/screen/user/processing/processing.dart';

class BatchHome extends StatefulWidget {
  @override
  _BatchHomeState createState() => _BatchHomeState();
}

class _BatchHomeState extends State<BatchHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Option'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GardenHistory()));
            },
            child: Text('Garden History'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DailyWorkEntry()));
            },
            child: Text('Daily Work Entry'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Processing()));
            },
            child: Text('Processing and Packaging entries'),
          ),
        ],
      ),
    );
  }
}
