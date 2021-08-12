import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/provider/dailyWork/dailyWorkProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
import 'package:fluttertest/screen/user/dailyWorkEntry/dailyWorkEntry.dart';
import 'package:fluttertest/screen/user/dailyWorkEntry/detailDailyWork.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../services/auth.dart';

class HomeDailyWorkEntry extends StatefulWidget {
  String dailyWorkId;
  HomeDailyWorkEntry(
    this.dailyWorkId,
  );
  @override
  _HomeDailyWorkEntryState createState() => _HomeDailyWorkEntryState();
}

class _HomeDailyWorkEntryState extends State<HomeDailyWorkEntry> {
  final AuthService _auth = AuthService();
  final spinkit = SpinKitChasingDots(
    color: Colors.grey[200],
    size: 50.0,
  );

  void showDialogBox() {
    showCupertinoDialog(
        context: context,
        builder: (_) => Container(
              child: AlertDialog(
                content: Container(width: 50, height: 50, child: spinkit),

                // actions: [
                //   FlatButton(
                //     onPressed: () {za
                //       Navigator.pop(context);
                //     },
                //     child: Text('No'),
                //   ),
                //   FlatButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     child: Text('Ok'),
                //   ),
                // ],
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pBatch = Provider.of<PRoom>(context, listen: false);
      pBatch.wrapperGetRoom(context);
      final pDailyWork = Provider.of<PDailyWork>(context, listen: false);
      pDailyWork.dailyWorkUid = widget.dailyWorkId;
      pDailyWork.wrapperGetDailyWork(context, widget.dailyWorkId);
    });
  }

  @override
  Widget build(BuildContext context) {
    double lWidth = 100;
    double rWidth = 100;
    final pRoom = Provider.of<PRoom>(context);
    final pDailyWork = Provider.of<PDailyWork>(context);

    void showConfirmDeleteDialogBox(String dailyWorkId) async {
      showCupertinoDialog(
          context: context,
          builder: (_) => Container(
                child: AlertDialog(
                  content: Text(' will be deleted!'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () async {
                        showDialogBox();
                        await pDailyWork.wrapperDeleteDailyWork(
                            http.Client(), widget.dailyWorkId, dailyWorkId);
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
        title: Text('Garden History'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            pDailyWork.dailyWorkUid = widget.dailyWorkId;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider.value(value: pRoom),
                        ChangeNotifierProvider.value(value: pDailyWork)
                      ],
                      child: DailyWorkEntry(widget.dailyWorkId),
                    )));
          },
          label: Text('Add Garden History')),
      body: pDailyWork.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pDailyWork.lDailyWork.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailDailyWork(pDailyWork.lDailyWork[index])));
                  },
                  child: Card(
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(DateFormat.yMMMd().format(DateTime.parse(
                          pDailyWork.lDailyWork[index].createdAt))),
                      subtitle: Column(children: [
                        Row(
                          children: [
                            Container(width: lWidth, child: Text('Room')),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                child: Text(pDailyWork.lDailyWork[index].room))
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                width: lWidth, child: Text('Total Hours')),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                child: Text(
                                    pDailyWork.lDailyWork[index].totalHours))
                          ],
                        ),
                      ]),
                      trailing: GestureDetector(
                        child: Icon(Icons.highlight_off),
                        onTap: () async {
                          print('Error');
                          await showConfirmDeleteDialogBox(
                              pDailyWork.lDailyWork[index].id);
                        },
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
