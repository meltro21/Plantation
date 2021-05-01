import 'package:flutter/material.dart';

import '../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.brown[100],
      appBar: AppBar(
        // backgroundColor: Colors.brown[400],
        // elevation: 0.0,
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.arrow_back),
              label: Text('back'))
        ],
        title: Text('Sign up'),
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
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: emailController,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                        controller: passwordController,
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
                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () async {
                              print(emailController.text);
                              print(passwordController.text);
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
                                  });
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                'Sign Up',
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
