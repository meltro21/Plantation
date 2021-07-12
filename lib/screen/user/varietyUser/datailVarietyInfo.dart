import 'package:flutter/material.dart';
import 'package:fluttertest/models/varietyInfo.dart';

class DetailVarietyInfo extends StatefulWidget {
  VarietyInfoModel varietyInfo;
  DetailVarietyInfo(this.varietyInfo);

  @override
  _DetailVarietyInfoState createState() => _DetailVarietyInfoState();
}

class _DetailVarietyInfoState extends State<DetailVarietyInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('Room Name: ${widget.varietyInfo.enterRoomName}'),
            Text('No Of Plants: ${widget.varietyInfo.noOfPlants}'),
            Text('Entry Into Room: ${widget.varietyInfo.enterRoomDate}')
          ],
        ),
      ),
    );
  }
}
