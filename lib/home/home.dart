import 'package:brewcrew/home/settings.dart';
import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final authService _service=authService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPane(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[500],
          elevation: 5.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('LOGOUT'),
              onPressed: () async{
                  await _service.signout();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('SETTINGS'),
              onPressed: ()=>_showSettingsPane()
            ),
          ],
        ),body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
          child: BrewList()),
      ),
    );
  }
}
