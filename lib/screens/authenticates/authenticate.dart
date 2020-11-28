import 'package:firebase_app1/screens/authenticates/register.dart';
import 'package:firebase_app1/screens/authenticates/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signIn = true;
  void toggleView(){
    setState(() => signIn = !signIn); 
    } 
   @override
  Widget build(BuildContext context) {
    return Container(
      child: signIn ? SignIn(toggleView) : Register(toggleView)
    );
  }
}
