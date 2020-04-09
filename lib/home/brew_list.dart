import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/models/brew.dart';
import 'brew_tile.dart';
class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews=Provider.of<List<Brew>>(context)??[];
    brews.forEach((brew){
      debugPrint(brew.name);
      debugPrint(brew.sugars);
      debugPrint(brew.strength.toString());
    });
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
