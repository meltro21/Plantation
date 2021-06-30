import 'package:flutter/material.dart';
import 'package:fluttertest/screen/user/processing/processingVariety.dart';

class Processing extends StatefulWidget {
  @override
  _ProcessingState createState() => _ProcessingState();
}

class _ProcessingState extends State<Processing> {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProcessingVariety()));
              },
              child: Text('Variety1')),
          TextButton(onPressed: () {}, child: Text('Variety2')),
          TextButton(onPressed: () {}, child: Text('Variety3')),
        ],
      ),
    );
  }
}
