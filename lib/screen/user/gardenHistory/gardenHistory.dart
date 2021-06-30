import 'package:flutter/material.dart';
import 'package:fluttertest/screen/user/gardenHistory/variety.dart';

class GardenHistory extends StatefulWidget {
  @override
  _GardenHistoryState createState() => _GardenHistoryState();
}

class _GardenHistoryState extends State<GardenHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garden History'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GardenVariety()));
              },
              child: Text('Variety1')),
          TextButton(onPressed: () {}, child: Text('Variety2')),
          TextButton(onPressed: () {}, child: Text('Variety3')),
        ],
      ),
    );
  }
}
