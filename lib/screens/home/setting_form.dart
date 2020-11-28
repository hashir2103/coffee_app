//when need data in one wigdet then we can use stream builder
//when need data in multiple wigdet then we can use stream provider
//you can use stream builder for multiple widget but it become harder to maintain

import 'package:firebase_app1/models/user.dart';
import 'package:firebase_app1/services/database.dart';
import 'package:firebase_app1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app1/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update your Brew Settings',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Your Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please Enter A Name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: userData
                          .sugars, //default value to show from db b4 selecting any option
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar, //value of selected option
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugar = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Slider(
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) => setState(() => _currentStrength = val
                          .round()), //val return double so round it to nearst int
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor: Colors.brown[_currentStrength ??
                          100], //if currentstrenght not null then use that else use 100
                      inactiveColor: Colors.brown[_currentStrength ?? 100],
                    ),
                    RaisedButton(
                        color: Colors.brown,
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? userData.name,
                                _currentSugar ?? userData.sugars,
                                _currentStrength ?? userData.strength);
                            Navigator.pop(context); //gonna pop bottomsheet
                          }
                        })
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
