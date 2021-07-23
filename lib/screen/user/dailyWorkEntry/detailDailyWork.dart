import 'package:flutter/material.dart';
import 'package:fluttertest/models/dailyWork.dart';

class DetailDailyWork extends StatefulWidget {
  DailyWorkModel dailyWork;

  DetailDailyWork(this.dailyWork);

  @override
  _DetailDailyWorkState createState() => _DetailDailyWorkState();
}

class _DetailDailyWorkState extends State<DetailDailyWork> {
  double titleWidth = 90;
  double resultWidth = 90;
  double sizedBoxHeight = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //.                           .
        title: Text("Detail"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.lightsCondition != 'N/A'
                          ? Text('Lights')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.lightsCondition != 'N/A'
                          ? Text(widget.dailyWork.lightsCondition)
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
                      child: widget.dailyWork.oFansCondition != 'N/A'
                          ? Text('Oscillating Fans')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.oFansCondition != 'N/A'
                          ? Text(widget.dailyWork.oFansCondition)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.oFansCondition != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.heatersCondition != 'N/A'
                          ? Text('Heaters')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.heatersCondition != 'N/A'
                          ? Text(widget.dailyWork.heatersCondition)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.heatersCondition != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.eFansCondition != 'N/A'
                          ? Text('Exaust Fans')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.eFansCondition != 'N/A'
                          ? Text(widget.dailyWork.eFansCondition)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.eFansCondition != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.dehumidifierCondition != 'N/A'
                          ? Text('Dehumidifier')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.dehumidifierCondition != 'N/A'
                          ? Text(widget.dailyWork.dehumidifierCondition)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.dehumidifierCondition != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.acCondition != 'N/A'
                          ? Text('Ac')
                          : SizedBox(),
                    ),
                    Container(
                      width: resultWidth,
                      child: widget.dailyWork.acCondition != 'N/A'
                          ? Text(widget.dailyWork.acCondition)
                          : SizedBox(),
                    )
                  ],
                ),
                widget.dailyWork.acCondition != 'N/A'
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
                widget.dailyWork.gPlant != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Container(
                      width: titleWidth,
                      child: widget.dailyWork.administrationPlant != 'N/A'
                          ? Text('Administration Plant')
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
                widget.dailyWork.administrationPlant != 'N/A'
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
                          ? Text('Alternate Spray')
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
                widget.dailyWork.bugs != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
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
                widget.dailyWork.waterORSoilTreatment != 'N/A'
                    ? SizedBox(
                        height: sizedBoxHeight,
                      )
                    : SizedBox(),
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
            )

            // Row(
            //   children: [
            //     Container(
            //       width: 85,
            //       child: Column(
            //         children: [
            //           widget.dailyWork.lightsCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft, child: Text("Lights"))
            //               : SizedBox(),
            //           widget.dailyWork.oFansCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text("Oscillating Fans"))
            //               : SizedBox(),
            //           widget.dailyWork.heatersCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text("Heaters"))
            //               : SizedBox(),
            //           widget.dailyWork.eFansCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text("Exaust Fans"))
            //               : SizedBox(),
            //           widget.dailyWork.dehumidifierCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text("Dehumidifier"))
            //               : SizedBox(),
            //           widget.dailyWork.lightsCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft, child: Text("Lights"))
            //               : SizedBox(),
            //           widget.dailyWork.lightsCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft, child: Text("Lights"))
            //               : SizedBox(),
            //           widget.dailyWork.lightsCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft, child: Text("Lights"))
            //               : SizedBox(),
            //           widget.dailyWork.waterORSoilTreatment != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text("Water or Soil Treatment"))
            //               : SizedBox(),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       width: 85,
            //       child: Column(
            //         children: [
            //           widget.dailyWork.lightsCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text(widget.dailyWork.lightsCondition))
            //               : SizedBox(),
            //           widget.dailyWork.oFansCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text(widget.dailyWork.oFansCondition))
            //               : SizedBox(),
            //           widget.dailyWork.heatersCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text(widget.dailyWork.heatersCondition))
            //               : SizedBox(),
            //           widget.dailyWork.eFansCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text(widget.dailyWork.eFansCondition))
            //               : SizedBox(),
            //           widget.dailyWork.dehumidifierCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text(widget.dailyWork.dehumidifierCondition))
            //               : SizedBox(),
            //           widget.dailyWork.lightsCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text(widget.dailyWork.lightsCondition))
            //               : SizedBox(),
            //           widget.dailyWork.lightsCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft, child: Text("Lights"))
            //               : SizedBox(),
            //           widget.dailyWork.lightsCondition != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft, child: Text("Lights"))
            //               : SizedBox(),
            //           widget.dailyWork.waterORSoilTreatment != 'N/A'
            //               ? Container(
            //                   alignment: Alignment.topLeft,
            //                   child: Text("Water or Soil Treatment"))
            //               : SizedBox(),
            //         ],
            //       ),
            //     ),
            //   ],
            // )

            ///previous design
            // Column(
            //   textBaseline: TextBaseline.alphabetic,
            //   children: [
            //     widget.dailyWork.lightsCondition != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Lights                                        :${widget.dailyWork.lightsCondition}"))
            //         : SizedBox(),
            //     widget.dailyWork.oFansCondition != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "OFans                                        :${widget.dailyWork.oFansCondition}"))
            //         : SizedBox(),
            //     widget.dailyWork.heatersCondition != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Heaters                                     :${widget.dailyWork.heatersCondition}"))
            //         : SizedBox(),
            //     widget.dailyWork.eFansCondition != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Exaust Fans                             : ${widget.dailyWork.eFansCondition}"))
            //         : SizedBox(),
            //     widget.dailyWork.dehumidifierCondition != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Dehumidifier                            : ${widget.dailyWork.dehumidifierCondition}"),
            //           )
            //         : SizedBox(),
            //     widget.dailyWork.acCondition != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Ac                                              : ${widget.dailyWork.acCondition}"))
            //         : SizedBox(),
            //     widget.dailyWork.tHigh != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Container(
            //               alignment: Alignment.topLeft,
            //               child: Text(
            //                   "Temperatur High                     :     ${widget.dailyWork.tHigh}"),
            //             ))
            //         : SizedBox(),
            //     widget.dailyWork.tLow != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Temperature Low                    :       ${widget.dailyWork.tLow}"))
            //         : SizedBox(),
            //     widget.dailyWork.hHigh != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text("Humadity High  : ${widget.dailyWork.hHigh}"))
            //         : SizedBox(),
            //     widget.dailyWork.hLow != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text("Humadity Low : ${widget.dailyWork.hLow}"))
            //         : SizedBox(),
            //     widget.dailyWork.feed != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text("Feed       : ${widget.dailyWork.feed}"))
            //         : SizedBox(),
            //     widget.dailyWork.flush != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text("Flush       : ${widget.dailyWork.flush}"))
            //         : SizedBox(),
            //     widget.dailyWork.gPlant != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "General Plant Care        : ${widget.dailyWork.gPlant}"))
            //         : SizedBox(),
            //     widget.dailyWork.administrationPlant != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Administration Plants      : ${widget.dailyWork.administrationPlant}"),
            //           )
            //         : SizedBox(),
            //     widget.dailyWork.fBuggySpray != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Foilar Buggy Spray  : ${widget.dailyWork.fBuggySpray}"))
            //         : SizedBox(),
            //     widget.dailyWork.fRinse != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text("Foilar Rinse : ${widget.dailyWork.fRinse}"))
            //         : SizedBox(),
            //     widget.dailyWork.fFoodSpray != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Foilar Food Spray       : ${widget.dailyWork.fFoodSpray}"),
            //           )
            //         : SizedBox(),
            //     widget.dailyWork.aSpray != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Alternate Spray       : ${widget.dailyWork.aSpray}"))
            //         : SizedBox(),
            //     widget.dailyWork.bugs != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text("Bugs       : ${widget.dailyWork.bugs}"))
            //         : SizedBox(),
            //     widget.dailyWork.waterORSoilTreatment != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Water or Soil Bug Treatment: ${widget.dailyWork.waterORSoilTreatment}"),
            //           )
            //         : SizedBox(),
            //     widget.dailyWork.transplanting != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Transplanting                       : ${widget.dailyWork.transplanting}"))
            //         : SizedBox(),
            //     widget.dailyWork.topping != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Topping                                   : ${widget.dailyWork.topping}"))
            //         : SizedBox(),
            //     widget.dailyWork.pruning != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Pruning                                   : ${widget.dailyWork.pruning}"))
            //         : SizedBox(),
            //     widget.dailyWork.staking != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Staking                                   : ${widget.dailyWork.staking}"))
            //         : SizedBox(),
            //     widget.dailyWork.cloning != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Cloning                                   : ${widget.dailyWork.cloning}"))
            //         : SizedBox(),
            //     widget.dailyWork.harvest != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Harvest                                   : ${widget.dailyWork.harvest}"))
            //         : SizedBox(),
            //     widget.dailyWork.cleaning != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Cleaning                                 : ${widget.dailyWork.cleaning}"))
            //         : SizedBox(),
            //     widget.dailyWork.maintenance != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Maintenance                          : ${widget.dailyWork.maintenance}"))
            //         : SizedBox(),
            //     widget.dailyWork.construction != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Construction                          : ${widget.dailyWork.construction}"))
            //         : SizedBox(),
            //     widget.dailyWork.notes != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Notes                                       : ${widget.dailyWork.notes}"))
            //         : SizedBox(),
            //     widget.dailyWork.totalHours != 'N/A'
            //         ? Container(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //                 "Total Hours                             : ${widget.dailyWork.totalHours}"))
            //         : SizedBox()
            //   ],
            // ),
            ),
      ),
    );
  }
}
