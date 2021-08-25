import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
import 'package:fluttertest/provider/room/timeProvider.dart';
import 'package:fluttertest/screen/admin/batches/addBatch.dart';
import 'package:fluttertest/screen/admin/batches/variety/variety.dart';
import 'package:fluttertest/screen/admin/room/addRoom.dart';
import 'package:fluttertest/screen/admin/room/time/addRoomTime.dart';
import 'package:fluttertest/screen/admin/room/time/roomTimeHome.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:provider/provider.dart';

class RoomHome extends StatefulWidget {
  @override
  _RoomHomeState createState() => _RoomHomeState();
}

class _RoomHomeState extends State<RoomHome> {
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
      final pBatch = Provider.of<BatchP>(context, listen: false);
      pBatch.wrapperGetBatches(context);
      final pRoom = Provider.of<PRoom>(context, listen: false);
      pRoom.wrapperGetRoom(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final pRoom = Provider.of<BatchP>(
    //   context,
    // );
    // final pVariety = Provider.of<PVariety>(
    //   context,
    // );
    // final pVarietyHistory = Provider.of<PVarietyHistory>(
    //   context,
    // );
    final pRoom = Provider.of<PRoom>(
      context,
    );
    final pRoomTime = Provider.of<PRoomTime>(
      context,
    );
    final pBatch = Provider.of<BatchP>(
      context,
    );

    void showConfirmDeleteDialogBox(String roomId) async {
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
                        await pRoom.wrapperDeleteRoom(context, roomId);
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
        title: Text('Room List'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColorDark,
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider.value(value: pRoom),
                        ],
                        child: AddRoom(),
                      )),
            );
          },
          label: Text('Add Room')),
      body: pRoom.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pRoom.lRoom.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider.value(
                                      value: pRoomTime),
                                  ChangeNotifierProvider.value(value: pBatch),
                                ],
                                child: RoomTimeHome(pRoom.lRoom[index].id),
                              )));
                    },
                    title: Text(
                      '${pRoom.lRoom[index].name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: GestureDetector(
                      child: Icon(Icons.highlight_off),
                      onTap: () async {
                        await showConfirmDeleteDialogBox(pRoom.lRoom[index].id);
                      },
                    ),
                  ),
                );
              }),
    );
  }
}
