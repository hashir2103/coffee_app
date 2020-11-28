import 'package:firebase_app1/services/auth.dart';
import 'package:firebase_app1/shared/constants.dart';
import 'package:firebase_app1/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();

  final Function toggleview;
  SignIn(this.toggleview);
}

class _SignInState extends State<SignIn> {
  final Authservices _auth = Authservices();
  final _formkey = GlobalKey<FormState>();

  bool loading = false;
  String email;
  String password;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign In to Brew Crew'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () => widget
                      .toggleview(), //widget here refer to root widget of this stateclass means  = SignIn
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  textColor: Colors.white70,
                ),
              ],
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        onChanged: (val) => email = val,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        onChanged: (val) => password = val,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.brown[400],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          //if validator return null then this val is true else false
                          if (_formkey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInwithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Error Login with those credential! try again';
                              });
                            }
                          }
                        },
                      ),
                      RaisedButton(
                        color: Colors.brown[400],
                        child: Text(
                          'Google Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          dynamic result = await _auth.handleGoogleSignIn();
                          print(result);
                          setState(() => loading = true);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Error Login with Google! try again';
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
