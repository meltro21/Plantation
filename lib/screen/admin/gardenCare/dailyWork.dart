import 'package:flutter/material.dart';
import 'package:fluttertest/models/workers.dart';
import 'package:fluttertest/provider/dailyWork/dailyWorkProvider.dart';
import 'package:fluttertest/provider/gardenCareProvider/workerProvider.dart';
import 'package:fluttertest/screen/admin/gardenCare/individualDailyWork.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:provider/provider.dart';

class DailyWorkHome extends StatefulWidget {
  // List<WorkerModel> workers;
  // DailyWorkHome(this.workers);
  @override
  _DailyWorkHomeState createState() => _DailyWorkHomeState();
}

class _DailyWorkHomeState extends State<DailyWorkHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pBatch = Provider.of<PWorker>(context, listen: false);
      pBatch.wrapperGetWorkers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pWorker = Provider.of<PWorker>(context);
    final pDailyWork = Provider.of<PDailyWork>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Select Worker'),
      ),
      body: pWorker.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pWorker.lWorker.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(
                      pWorker.lWorker[index].userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      print('id is ${pWorker.lWorker[index].firestoreId}');
                      pDailyWork.dailyWorkUid =
                          pWorker.lWorker[index].firestoreId;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider.value(
                                      value: pDailyWork),
                                ],
                                child: IndividualDailyWork(
                                    pWorker.lWorker[index].firestoreId),
                              )));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => IndividualDailyWork(
                      //             pWorker.lWorker[index].firestoreId)));
                    },
                  ),
                );
              }),
    );
  }
}
