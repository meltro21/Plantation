
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './shared/loading.dart';
import './services/auth.dart';
import 'wrapper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp()
    );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context,snapshot){
          if (snapshot.hasError) {
           return Text('Error');
          }
          else if(snapshot.hasData)
          {
            return StreamProvider<User>.value(

            value: AuthService().user ,
            initialData: null,
            child: Wrapper());
          }
          else{
            return Loading();
          }
          },
        ),
      );
    }
}


