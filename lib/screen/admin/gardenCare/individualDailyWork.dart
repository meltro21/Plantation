import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/dailyWork.dart';
import 'package:fluttertest/provider/dailyWork/dailyWorkProvider.dart';
import 'package:fluttertest/screen/user/dailyWorkEntry/detailDailyWork.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

List<DailyWorkModel> parseVarieties(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed
      .map<DailyWorkModel>((json) => DailyWorkModel.fromJson(json))
      .toList();
}

class IndividualDailyWork extends StatefulWidget {
  String uid;
  IndividualDailyWork(this.uid);
  @override
  _IndividualDailyWorkState createState() => _IndividualDailyWorkState();
}

class _IndividualDailyWorkState extends State<IndividualDailyWork> {
  Future<List<DailyWorkModel>> getVarities(http.Client client) async {
    print('start FilterDailyWork get');
    var queryParameters = {'firestoreId': '${widget.uid}'};
    var uri = Uri.https(
        'hughplantation.herokuapp.com', '/filterDailyWork', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);
    if (response.statusCode == 200) {}

    print(response);
    print('end filterVariety get');
    return compute(parseVarieties, response.body);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pDailyWork = Provider.of<PDailyWork>(context, listen: false);
      pDailyWork.wrapperGetDailyWork(context, widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pDailyWork = Provider.of<PDailyWork>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Daily Work'),
      ),
      body: pDailyWork.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pDailyWork.lDailyWork.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider.value(
                                      value: pDailyWork),
                                ],
                                child: DetailDailyWork(
                                    pDailyWork.lDailyWork[index]),
                              )));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             DetailDailyWork(pDailyWork.lDailyWork[index])));
                    },
                    child: Card(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(
                          DateFormat.yMMMd().format(DateTime.parse(
                              pDailyWork.lDailyWork[index].createdAt)),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text('Room'),
                                SizedBox(width: 10),
                                Text(pDailyWork.lDailyWork[index].room)
                              ],
                            ),
                            Row(
                              children: [
                                Text('Total Hour'),
                                SizedBox(width: 10),
                                Text(pDailyWork.lDailyWork[index].totalHours)
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              }),
    );
  }
}
