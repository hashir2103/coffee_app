import 'package:firebase_app1/screens/wrapper.dart';
import 'package:firebase_app1/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //by using provider we ensure we are providing stream data to all widget beneath Provider means we can decide where we want to acces which widget
    return StreamProvider<User>.value( //<User> = return type 
      value: Authservices().user, //value: we specify what stream we want listen and what data we want
      //this mean all widget can access user id value
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        ),
    );
  }
}

