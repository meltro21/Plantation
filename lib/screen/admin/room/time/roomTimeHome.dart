import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/room/timeProvider.dart';
import 'package:fluttertest/screen/admin/room/time/addRoomTime.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

DateTime dTime = DateTime.now();
int hours = dTime.hour;
int min = dTime.minute;
int sec = dTime.second;
int msec = dTime.millisecond;
int micros = dTime.microsecond;
DateTime dStart = dTime.subtract(Duration(
    hours: hours,
    minutes: min,
    seconds: sec,
    milliseconds: msec,
    microseconds: micros));

class RoomTimeHome extends StatefulWidget {
  String roomId;
  RoomTimeHome(this.roomId);
  @override
  _RoomTimeHomeState createState() => _RoomTimeHomeState();
}

class _RoomTimeHomeState extends State<RoomTimeHome> {
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );

  void smallLoading() {
    showCupertinoDialog(
        context: context,
        builder: (_) => Container(
              child: AlertDialog(
                content: Container(width: 50, height: 50, child: spinkit),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pRoomTime = Provider.of<PRoomTime>(context, listen: false);
      pRoomTime.wrapperGetRoomTime(context, widget.roomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pRoomTime = Provider.of<PRoomTime>(
      context,
    );
    final pBatch = Provider.of<BatchP>(
      context,
    );

    void showConfirmDeleteDialogBox(String roomTimeId) async {
      showCupertinoDialog(
          context: context,
          builder: (_) => Container(
                child: AlertDialog(
                  content: Text('Are you sure you want to delete!'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () async {
                        smallLoading();
                        await pRoomTime.wrapperDeleteRoomTime(
                            context, widget.roomId, roomTimeId);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              ));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Room Time'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColorDark,
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider.value(value: pRoomTime),
                          ChangeNotifierProvider.value(value: pBatch),
                        ],
                        child: AddRoomTime(widget.roomId),
                      )),
            );
          },
          label: Text('Add Room Time')),
      body: pRoomTime.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pRoomTime.lRoomTime.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print('start is $dStart');
                    print('end time ${pRoomTime.lRoomTime[index].endDate}');
                    //pRoomTime.currentBatchIndex = index;
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => MultiProvider(
                    //           providers: [
                    //             ChangeNotifierProvider.value(value: pBatch),
                    //             ChangeNotifierProvider.value(value: pVariety),
                    //             ChangeNotifierProvider.value(
                    //                 value: pVarietyHistory),
                    //             ChangeNotifierProvider.value(value: pRoom),
                    //           ],
                    //           child: Variety(),
                    //         )));
                  },
                  child: Card(
                    color: DateTime.parse(pRoomTime.lRoomTime[index].endDate)
                                .difference(dStart)
                                .inDays >
                            3
                        ? Colors.green
                        : DateTime.parse(pRoomTime.lRoomTime[index].endDate)
                                        .difference(dStart)
                                        .inDays <=
                                    3 &&
                                DateTime.parse(
                                            pRoomTime.lRoomTime[index].endDate)
                                        .difference(dStart)
                                        .inDays >=
                                    0
                            ? Colors.orange
                            : Colors.red,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        'Batch ${pRoomTime.lRoomTime[index].batchNo}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat.yMMMEd().format(DateTime.parse(
                              pRoomTime.lRoomTime[index].endDate))),
                          Text(
                              '${DateTime.parse(pRoomTime.lRoomTime[index].endDate).difference(dStart).inDays} Days'),
                        ],
                      ),
                      trailing: GestureDetector(
                        child: Icon(Icons.highlight_off),
                        onTap: () async {
                          print(dStart);
                          await showConfirmDeleteDialogBox(
                              pRoomTime.lRoomTime[index].id);
                        },
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
