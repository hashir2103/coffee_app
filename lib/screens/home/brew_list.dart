import 'package:firebase_app1/models/brew.dart';
import 'package:firebase_app1/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews =
        Provider.of<List<Brew>>(context) ?? []; //now brews have all db data as list

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return BrewTile(brew : brews[index]);
        });
  }
}
