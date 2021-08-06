import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertest/provider/batchProvider.dart';
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
                StreamProvider<User>.value(
                    value: AuthService().user, initialData: null),
                ChangeNotifierProvider.value(value: BatchP()),
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
