import 'package:firebase_app1/models/brew.dart';
import 'package:firebase_app1/screens/home/brew_list.dart';
import 'package:firebase_app1/screens/home/setting_form.dart';
import 'package:firebase_app1/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app1/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  final Authservices _auth = Authservices();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value( //acessing stream data provide by fb db
        value: DatabaseService().brewsSnapshot, //in desendent wigdet we can access up-to-date data of fb db. 
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signout();
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
              )
          ),
          child: BrewList()
          ) ,
      ),
    );
  }
}
