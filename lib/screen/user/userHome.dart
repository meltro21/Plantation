// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertest/screen/user/batchHome.dart';

// import 'package:provider/provider.dart';

// import '../../services/auth.dart';

// class UserHome extends StatefulWidget {
//   @override
//   _UserHomeState createState() => _UserHomeState();
// }

// class _UserHomeState extends State<UserHome> {
//   final AuthService _auth = AuthService();
//   int count = 0;
//   final items = List<String>.generate(20, (i) => "Item $i");

//   @override
//   //BUILD METHOD
//   Widget build(BuildContext context) {
//     // for (var i in items) {
//     //   print("i is $i");
//     // }
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sticky Finger'),
//         actions: [
//           FlatButton.icon(
//               onPressed: () async {
//                 await _auth.signOut();
//               },
//               icon: Icon(Icons.person),
//               label: Text('Sign out'))
//         ],
//       ),
//       body: Container(
//         child: ListView.builder(itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               print("Button is presses");
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => BatchHome()));
//             },
//             child: ListTile(
//               title: Text('${items[index]}'),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fluttertest/models/workers.dart';
import 'package:fluttertest/screen/user/batchHome.dart';
import 'package:fluttertest/screen/user/dailyWorkEntry/homeDailyWorkEntry.dart';
import 'package:fluttertest/shared/loading.dart';
import 'package:http/http.dart' as http;

import '../../services/auth.dart';

List<WorkerModel> parseWorkers(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('end patseBatch get');
  return parsed.map<WorkerModel>((json) => WorkerModel.fromJson(json)).toList();
}

Future<List<WorkerModel>> getWorkers(http.Client client) async {
  print('start workers get');
  final response = await client
      .get(Uri.parse('https://hughplantation.herokuapp.com/workers'));

  if (response.statusCode == 200) {}

  print(response);
  print('end workers get');
  return compute(parseWorkers, response.body);
}

class UserHome extends StatefulWidget {
  String uid;
  UserHome(this.uid);
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final AuthService _auth = AuthService();
  void navigateToHomeDailyWorkEntry(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeDailyWorkEntry(widget.uid, navigateToHomeDailyWorkEntry)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Sign out'))
          ],
        ),
        body: FutureBuilder(
            future: getWorkers(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('snapshot has data');
                print(snapshot.data);
                for (var i in snapshot.data) {
                  print('Mongo WotkerId(firestore) ${i.firestoreId}');
                  print('Mongo UserName ${i.userName}');
                }
                // for (var i in snapshot.data) {
                //   print('naem is ${snapshot.data[i].userName}');
                // }
                return Center(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            elevation: 5,
                            child: Container(
                              height: 150,
                              width: 150,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserBatches()));
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Batches')),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                              height: 150,
                              width: 150,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeDailyWorkEntry(widget.uid,
                                                  navigateToHomeDailyWorkEntry)));
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Daily Work')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return snapshot.error;
              } else {
                return Loading();
              }
            }));
  }
}
