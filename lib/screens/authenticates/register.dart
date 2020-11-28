import 'package:firebase_app1/services/auth.dart';
import 'package:firebase_app1/shared/constants.dart';
import 'package:firebase_app1/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();

  final Function toggleview;
  Register(this.toggleview);
}

class _RegisterState extends State<Register> {
  final Authservices _auth = Authservices();
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Register Now to Brew Crew'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () => widget
                      .toggleview(), // as we are using class not state so thats why widget which mean Register not Registerstate
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
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
                          validator: (val) =>
                              val.isEmpty ? 'Enter Email' : null,
                          onChanged: (val) => email = val,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email')),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          validator: (val) => val.length < 6
                              ? 'Enter password greater then 6 char'
                              : null,
                          onChanged: (val) => password = val,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password')),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.brown[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          //if validator return null then this val is true else false
                          if (_formkey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmail(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please Supply a valid email';
                              });
                            }
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
