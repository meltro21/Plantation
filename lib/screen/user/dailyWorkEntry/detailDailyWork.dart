import 'package:flutter/material.dart';
import 'package:fluttertest/models/dailyWork.dart';

class DetailDailyWork extends StatefulWidget {
  DailyWorkModel dailyWork;

  DetailDailyWork(this.dailyWork);

  @override
  _DetailDailyWorkState createState() => _DetailDailyWorkState();
}

class _DetailDailyWorkState extends State<DetailDailyWork> {
  double titleWidth = 110;
  double resultWidth = 90;
  double sizedBoxHeight = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.lightsCondition != 'N/A' &&
                              widget.dailyWork.lightsCondition != 'Good'
                          ? Text('Lights')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.lightsCondition != 'N/A' &&
                              widget.dailyWork.lightsCondition != 'Good'
                          ? Text('Problem')
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.lightsCondition != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.oFansCondition != 'N/A' &&
                              widget.dailyWork.oFansCondition != 'Good'
                          ? Text('Oscillating Fans')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.oFansCondition != 'N/A' &&
                              widget.dailyWork.oFansCondition != 'Good'
                          ? Text(widget.dailyWork.oFansCondition != 'Good'
                              ? 'Problem'
                              : '')
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.oFansCondition != 'N/A' &&
                        widget.dailyWork.oFansCondition != 'Good'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.heatersCondition != 'N/A' &&
                              widget.dailyWork.heatersCondition != 'Good'
                          ? Text('Heaters')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.heatersCondition != 'N/A' &&
                              widget.dailyWork.heatersCondition != 'Good'
                          ? Text(widget.dailyWork.heatersCondition != 'Good'
                              ? 'Problem'
                              : '')
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.heatersCondition != 'N/A' &&
                        widget.dailyWork.heatersCondition != 'Good'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.eFansCondition != 'N/A' &&
                              widget.dailyWork.eFansCondition != 'Good'
                          ? Text('Exaust Fans')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.eFansCondition != 'N/A' &&
                              widget.dailyWork.eFansCondition != 'Good'
                          ? Text(widget.dailyWork.eFansCondition != 'Good'
                              ? 'Problem'
                              : '')
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.eFansCondition != 'N/A' &&
                        widget.dailyWork.eFansCondition != 'Good'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.dehumidifierCondition != 'N/A' &&
                              widget.dailyWork.dehumidifierCondition != 'Good'
                          ? Text('Dehumidifier')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.dehumidifierCondition != 'N/A' &&
                              widget.dailyWork.dehumidifierCondition != 'Good'
                          ? Text(
                              widget.dailyWork.dehumidifierCondition != 'Good'
                                  ? 'Problem'
                                  : '')
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.dehumidifierCondition != 'N/A' &&
                        widget.dailyWork.dehumidifierCondition != 'Good'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.acCondition != 'N/A' &&
                              widget.dailyWork.acCondition != 'Good'
                          ? Text('Ac')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.acCondition != 'N/A' &&
                              widget.dailyWork.acCondition != 'Good'
                          ? Text(widget.dailyWork.acCondition != 'Good'
                              ? 'Problem'
                              : '')
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.acCondition != 'N/A' &&
                        widget.dailyWork.acCondition != '      Good'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.tHigh != 'N/A'
                          ? Text('Temperature High')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.tHigh != 'N/A'
                          ? Text(widget.dailyWork.tHigh)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.tHigh != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.tLow != 'N/A'
                          ? Text('Temperature Low')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.tLow != 'N/A'
                          ? Text(widget.dailyWork.tLow)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.tLow != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.hHigh != 'N/A'
                          ? Text('Humidity High')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.hHigh != 'N/A'
                          ? Text(widget.dailyWork.hHigh)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.hHigh != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.hLow != 'N/A'
                          ? Text('Humidity Low')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.hLow != 'N/A'
                          ? Text(widget.dailyWork.hLow)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.hLow != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.feed != 'N/A'
                          ? Text('Feed')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.feed != 'N/A'
                          ? Text(widget.dailyWork.feed)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.feed != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.flush != 'N/A'
                          ? Text('Flush')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.flush != 'N/A'
                          ? Text(widget.dailyWork.flush)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.flush != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.fBuggySpray != 'N/A'
                          ? Text('Foilar Buggy Spray')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.fBuggySpray != 'N/A'
                          ? Text(widget.dailyWork.fBuggySpray)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.fBuggySpray != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.aSpray != 'N/A'
                          ? Text('Foilar Mould Spray')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.aSpray != 'N/A'
                          ? Text(widget.dailyWork.aSpray)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.aSpray != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.fRinse != 'N/A'
                          ? Text('Foilar Rinse Spray')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.fRinse != 'N/A'
                          ? Text(widget.dailyWork.fRinse)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.fRinse != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.fFoodSpray != 'N/A'
                          ? Text('Foilar Food Spray')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.fFoodSpray != 'N/A'
                          ? Text(widget.dailyWork.fFoodSpray)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.fFoodSpray != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.bugs != 'N/A'
                          ? Text('Bugs')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.bugs != 'N/A'
                          ? Text(widget.dailyWork.bugs)
                          : SizedBox(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.waterORSoilTreatment != 'N/A'
                          ? Text('Water or Soil Teatment')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.waterORSoilTreatment != 'N/A'
                          ? Text(widget.dailyWork.waterORSoilTreatment)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.flush != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.administrationPlant != 'N/A'
                          ? Text('Plant Sorting')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.administrationPlant != 'N/A'
                          ? Text(widget.dailyWork.administrationPlant)
                          : SizedBox(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.gPlant != 'N/A'
                          ? Text('General Plant Care')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.gPlant != 'N/A'
                          ? Text(widget.dailyWork.gPlant)
                          : SizedBox(),
                    )
                  ],
                ),
                // widget.dailyWork.gPlant != 'N/A'
                //     ? SizedBox(
                //         height: sizedBoxHeight,
                //       )
                //     : SizedBox(),
                // widget.dailyWork.administrationPlant != 'N/A'
                //     ? SizedBox(
                //         height: sizedBoxHeight,
                //       )
                //     : SizedBox(),
                // widget.dailyWork.fBuggySpray != 'N/A'
                //     ? SizedBox(
                //         height: sizedBoxHeight,
                //       )
                //     : SizedBox(),
                // widget.dailyWork.aSpray != 'N/A'
                //     ? SizedBox(
                //         height: sizedBoxHeight,
                //       )
                //     : SizedBox(),
                // widget.dailyWork.bugs != 'N/A'
                //     ? SizedBox(
                //         height: sizedBoxHeight,
                //       )
                //     : SizedBox(),
                // widget.dailyWork.waterORSoilTreatment != 'N/A'
                //     ? SizedBox(
                //         height: sizedBoxHeight,
                //       )
                //     : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.transplanting != 'N/A'
                          ? Text('Transplanting')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.transplanting != 'N/A'
                          ? Text(widget.dailyWork.transplanting)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.transplanting != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.topping != 'N/A'
                          ? Text('Topping')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.topping != 'N/A'
                          ? Text(widget.dailyWork.topping)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.topping != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.pruning != 'N/A'
                          ? Text('Prunning')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.pruning != 'N/A'
                          ? Text(widget.dailyWork.pruning)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.pruning != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.staking != 'N/A'
                          ? Text('Staking')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.staking != 'N/A'
                          ? Text(widget.dailyWork.staking)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.staking != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.cloning != 'N/A'
                          ? Text('Cloning')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.cloning != 'N/A'
                          ? Text(widget.dailyWork.cloning)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.cloning != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.harvest != 'N/A'
                          ? Text('Harvest')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.harvest != 'N/A'
                          ? Text(widget.dailyWork.harvest)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.harvest != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.cleaning != 'N/A'
                          ? Text('Cleaning')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.cleaning != 'N/A'
                          ? Text(widget.dailyWork.cleaning)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.cleaning != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.maintenance != 'N/A'
                          ? Text('Maintenance')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.maintenance != 'N/A'
                          ? Text(widget.dailyWork.maintenance)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.maintenance != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.construction != 'N/A'
                          ? Text('Construction')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.construction != 'N/A'
                          ? Text(widget.dailyWork.construction)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.construction != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.notes != 'N/A'
                          ? Text('Notes')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.notes != 'N/A'
                          ? Text(widget.dailyWork.notes)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.notes != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.totalHours != '0.0'
                          ? Text('Total Hours')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.totalHours != '0.0'
                          ? Text(widget.dailyWork.totalHours)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.totalHours != '0.0'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
              ],
            )),
      ),
    );
  }
}
