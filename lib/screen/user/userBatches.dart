// import 'package:flutter/material.dart';
// import 'package:fluttertest/screen/user/dailyWorkEntry/dailyWorkEntry.dart';
// import 'package:fluttertest/screen/user/gardenHistory/gardenHistory.dart';
// import 'package:fluttertest/screen/user/processing/processing.dart';

// class BatchHome extends StatefulWidget {
//   @override
//   _BatchHomeState createState() => _BatchHomeState();
// }

// class _BatchHomeState extends State<BatchHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Option'),
//       ),
//       body: Column(
//         children: [
//           TextButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => GardenHistory()));
//             },
//             child: Text('Garden History'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => DailyWorkEntry()));
//             },
//             child: Text('Daily Work Entry'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Processing()));
//             },
//             child: Text('Processing and Packaging entries'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/batch.dart';
import 'package:fluttertest/screen/admin/batches/addBatch.dart';
import 'package:fluttertest/screen/admin/batches/variety/variety.dart';
import 'package:fluttertest/screen/user/varietyUser/varietyUserHome.dart';
import 'package:fluttertest/shared/loading.dart';

import 'package:http/http.dart' as http;

import '../../../services/auth.dart';

List<Batch> parseBatch(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed.map<Batch>((json) => Batch.fromJson(json)).toList();
}

Future<List<Batch>> getBatches(http.Client client) async {
  print('start batches get');
  final response = await client
      .get(Uri.parse('https://hughplantation.herokuapp.com/batches'));

  if (response.statusCode == 200) {}

  print(response);
  print('end batches get');
  return compute(parseBatch, response.body);
}

class UserBatches extends StatefulWidget {
  @override
  _UserBatchesState createState() => _UserBatchesState();
}

class _UserBatchesState extends State<UserBatches> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text('Batch List'),
        ),
        body: FutureBuilder(
            future: getBatches(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VarietyUserHome(
                                      snapshot.data[index].id)));
                        },
                        child: Card(
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title:
                                Text('Batch ${snapshot.data[index].batchNo}'),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                print('snapshot has error');
                return snapshot.error;
              } else {
                return Loading();
              }
            }));
  }
}
