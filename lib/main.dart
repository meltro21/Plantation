import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertest/provider/batchProvider/batchProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyHistoryProvider.dart';
import 'package:fluttertest/provider/batchProvider/varietyProvider.dart';
import 'package:fluttertest/provider/dailyWork/dailyWorkProvider.dart';
import 'package:fluttertest/provider/room/timeProvider.dart';
import 'package:fluttertest/provider/weightProvider/weightProvider.dart';
import 'package:fluttertest/provider/workerProvider/workerProvider.dart';
import 'package:fluttertest/provider/room/roomProvider.dart';
import 'package:provider/provider.dart';

import './shared/loading.dart';
import './services/auth.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColorDark: Color(0xFFB39D86),
          primaryColorLight: Color(0xFFBFBFBF),
          accentColor: Colors.brown[50]),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          } else if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                //batch Providers
                StreamProvider<User>.value(
                    value: AuthService().user, initialData: null),
                ChangeNotifierProvider.value(value: BatchP()),
                ChangeNotifierProvider.value(value: PVariety()),
                ChangeNotifierProvider.value(value: PVarietyHistory()),
                //worker Providers
                ChangeNotifierProvider.value(value: PWorker()),
                //room Provider
                ChangeNotifierProvider.value(value: PRoom()),
                ChangeNotifierProvider.value(value: PRoomTime()),
                //dailyWorkProvider
                ChangeNotifierProvider.value(value: PDailyWork()),
                //weight Provider

                ChangeNotifierProvider.value(value: Pweight()),
              ],
              child: Wrapper(),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
