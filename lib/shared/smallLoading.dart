import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SmallLoading extends StatefulWidget {
  bool flag;

  SmallLoading(flag);

  @override
  _SmallLoadingState createState() => _SmallLoadingState();
}

class _SmallLoadingState extends State<SmallLoading> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.flag,
      child: Container(
        child: SpinKitCircle(),
      ),
    );
  }
}
