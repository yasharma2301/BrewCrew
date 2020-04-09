import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form vals
  String _currentName, _currentSugars;
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
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Blend your own brew:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    validator: (val) =>
                        val.isEmpty ? 'Please Enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                    decoration: InputDecoration(
                        hintText: 'Enter your name here',
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Name',
                        errorStyle:
                            TextStyle(color: Colors.red[900], fontSize: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.brown[900], width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.brown[900], width: 2.0))),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.brown[900], width: 1.0)),
                    ),
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  //slider
                  Slider(
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.brown[800],
                    child: Text(
                      'UPDATE',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData
                          (_currentSugars??userData.sugars, _currentName??userData.name, _currentStrength??userData.strength);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
