import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  void showDialogBox(String statement) {
    showCupertinoDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Alert'),
              content: Text(statement),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      // backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        // backgroundColor: Colors.brown[400],
        // elevation: 0.0,

        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   child: Stack(
            //     children: <Widget>[
            //       // Container(
            //       //   padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
            //       //   // height: 300.0,
            //       //   // child: Image(image: AssetImage('assets/ook3.jpg'),
            //       //   //   ),
            //       //   child: Text('Ready',
            //       //       style: TextStyle(
            //       //           fontSize: 60.0, fontWeight: FontWeight.bold)),
            //       //   ),
            //       // Container(
            //       //   padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
            //       //   child: Text('to Mingle',
            //       //       style: TextStyle(
            //       //           fontSize: 70.0, fontWeight: FontWeight.bold)),
            //       // ),
            //       Container(
            //         padding: EdgeInsets.fromLTRB(310.0, 165.0, 0.0, 0.0),
            //         child: Text('.',
            //             style: TextStyle(
            //                 fontSize: 80.0,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.red)),
            //       )
            //     ],
            //   ),
            // ),
            Form(
              key: _formKey,
              child: Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: emailController,
                      ),

                      SizedBox(height: 5.0),
                      // Container(
                      //   alignment: Alignment(1.0, 0.0),
                      //   padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      //   child: InkWell(
                      //     child: Text(
                      //       'Forgot Password',
                      //       style: TextStyle(
                      //           color: Colors.blue,
                      //           fontWeight: FontWeight.bold,
                      //           fontFamily: 'Montserrat',
                      //           decoration: TextDecoration.underline),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: () async {
                          print(emailController.text);
                          print(passwordController.text);
                          if (_formKey.currentState.validate()) {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: emailController.text)
                                .then((value) {
                              String s =
                                  "Password reset link is send to ${emailController.text}";
                              showDialogBox(s);
                              print('Exit this window');
                              //Navigator.pop(context);
                            }).catchError((onError) {
                              print("Error is $onError");
                              String s = "Unable to send link, Error: $onError";
                              showDialogBox(s);
                            });
                            // dynamic result =
                            //     await _auth.registerWithEmailAndPassword(
                            //         emailController.text,
                            //         passwordController.text);
                            // if (result == null) {
                            //   setState(() {
                            //     error = 'Please supply a valid email';
                            //   });
                            // }
                          }
                        },
                        child: Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Theme.of(context).primaryColorDark,
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'Send Reset Link',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      //SizedBox(height: 20.0),
                      // Container(
                      //   height: 40.0,
                      //   color: Colors.transparent,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         border: Border.all(
                      //             color: Colors.black,
                      //             style: BorderStyle.solid,
                      //             width: 1.0),
                      //         color: Colors.transparent,
                      //         borderRadius: BorderRadius.circular(20.0)),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: <Widget>[
                      //         Center(
                      //           child:
                      //               ImageIcon(AssetImage('assets/facebook.png')),
                      //         ),
                      //         SizedBox(width: 10.0),
                      //         Center(
                      //           child: Text('Log in with facebook',
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.bold,
                      //                   fontFamily: 'Montserrat')),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  )),
            ),
            //SizedBox(height: 15.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //       'New to Sales App ?',
            //       style: TextStyle(fontFamily: 'Montserrat'),
            //     ),
            //     SizedBox(width: 5.0),
            //     InkWell(
            //       onTap: () {
            //         Navigator.of(context).pushNamed('/signup');
            //       },
            //       child: Text(
            //         'Register',
            //         style: TextStyle(
            //             color: Colors.blue,
            //             fontFamily: 'Montserrat',
            //             fontWeight: FontWeight.bold,
            //             decoration: TextDecoration.underline),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
