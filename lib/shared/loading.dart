import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final spinkit = SpinKitChasingDots(
    color: Color(0xFFB39D86),
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Container(
          child: spinkit,
        ),
      ),
    );
  }
}
