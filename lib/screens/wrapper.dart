import 'package:firebase_app1/models/user.dart';
import 'package:firebase_app1/screens/authenticates/authenticate.dart';
import 'package:firebase_app1/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // <in angular bracket we specify what kind of data we going to recieve>

    final user = Provider.of<User>(context); //this give access User data
    print(user);
    //either return home or authenticate widget
    return (user==null) ? Authenticate() : Home();
  }
}
