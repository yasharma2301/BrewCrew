import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  final Function toggleView;

  register({this.toggleView});

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final authService _service = authService();

  //text Field State
  String error = '';
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.body2;
    return loading
        ? Loading()
        : Scaffold(
              resizeToAvoidBottomInset: false,
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () => widget.toggleView(),
                    icon: Icon(Icons.person),
                    label: Text('SIGN IN'))
              ],
              title: Text('Sign up for Brew Crew'),
              backgroundColor: Colors.brown[700],
            ),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/coffee_bg.png'),
                      fit: BoxFit.cover,
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 120.0,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Email' : null,
                        decoration: InputDecoration(
                            hintText: 'Enter your registered email',
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Email',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                color: Colors.red[900], fontSize: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.brown[900], width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.brown[900], width: 2.0))),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Enter a Password 6+ chars long'
                            : null,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Enter your password here',
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Password',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                color: Colors.red[900], fontSize: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.brown[900], width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.brown[900], width: 2.0))),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 50.0,
                        width: 200.0,
                        child: RaisedButton(

                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                          color: Colors.brown[800],
                          child: Text(
                            'REGISTER',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });

                              dynamic result = await _service.registerWithEmail(email, password);
                              if (result == null) {
                                setState(
                                    () => error = 'Please supply valid details');
                                    loading=false;
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        error,
                        style:
                            TextStyle(color: Colors.brown[900], fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
