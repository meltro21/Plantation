import 'package:flutter/material.dart';
import 'package:fluttertest/models/dailyWork.dart';

class DetailDailyWork extends StatefulWidget {
  DailyWorkModel dailyWork;
  DetailDailyWork(this.dailyWork);

  @override
  _DetailDailyWorkState createState() => _DetailDailyWorkState();
}

class _DetailDailyWorkState extends State<DetailDailyWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Text("Lights       : ${widget.dailyWork.lightsCondition}"),
            Text("OFans        : ${widget.dailyWork.oFansCondition}"),
            Text("Heaters      : ${widget.dailyWork.heatersCondition}"),
            Text("Exaust Fans  : ${widget.dailyWork.eFansCondition}"),
            Text("Dehumidifier : ${widget.dailyWork.dehumidifierCondition}"),
            Text("Ac                : ${widget.dailyWork.acCondition}"),
            Text("Temperatur High        : ${widget.dailyWork.tHigh}"),
            Text("Temperature Low      : ${widget.dailyWork.tLow}"),
            Text("Humadity High  : ${widget.dailyWork.hHigh}"),
            Text("Humadity Low : ${widget.dailyWork.hLow}"),
            Text("Feed       : ${widget.dailyWork.feed}"),
            Text("Flush       : ${widget.dailyWork.flush}"),
            Text("General Plant Care        : ${widget.dailyWork.gPlant}"),
            Text(
                "Administration Plants      : ${widget.dailyWork.administrationPlant}"),
            Text("Foilar Buggy Spray  : ${widget.dailyWork.fBuggySpray}"),
            Text("Foilar Rinse : ${widget.dailyWork.fRinse}"),
            Text("Foilar Food Spray       : ${widget.dailyWork.fFoodSpray}"),
            Text("Alternate Spray       : ${widget.dailyWork.aSpray}"),
            Text("Bugs       : ${widget.dailyWork.bugs}"),
            Text(
                "Water or Soil Bug Treatment      : ${widget.dailyWork.waterORSoilTreatment}"),
            Text("Transplanting  : ${widget.dailyWork.transplanting}"),
            Text("Topping : ${widget.dailyWork.topping}"),
            Text("Prunning      : ${widget.dailyWork.pruning}"),
            Text("Staking       : ${widget.dailyWork.staking}"),
            Text("Cloning      : ${widget.dailyWork.cloning}"),
            Text("Harvest      : ${widget.dailyWork.harvest}"),
            Text("Cleaning  : ${widget.dailyWork.cleaning}"),
            Text("Maintenance: ${widget.dailyWork.maintenance}"),
            Text("Contruction      : ${widget.dailyWork.construction}"),
            Text("NOtes      : ${widget.dailyWork.notes}"),
            Text("Total Hours     : ${widget.dailyWork.totalHours}"),
          ],
        ),
      ),
    );
  }
}
