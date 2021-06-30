import 'package:flutter/material.dart';
import 'package:fluttertest/authenticate/forgorPassword.dart';

import '../services/auth.dart';
import '../shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Indian Hub'),
            ),
            //  resizeToAvoidBottomPadding: false,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Form(
                        key: _formKey,
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
                                      borderSide:
                                          BorderSide(color: Colors.green))),
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
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                              obscureText: true,
                              controller: passwordController,
                            ),
                            // SizedBox(height: 5.0),
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
                            //Login
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
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              emailController.text,
                                              passwordController.text);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error =
                                              'Could not sign in with those credentials';
                                          print(
                                              'Email is: ${emailController.text} Password is: ${passwordController.text}');
                                        });
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'LOGIN',
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
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      )),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'New to Indian Hub ?',
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                      SizedBox(width: 5.0),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: GestureDetector(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Center(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
