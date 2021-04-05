//import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/loading.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final wrapperUser = Provider.of<Useruid>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: wrapperUser.uid).userdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Update brew prefrence",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: userData.name,
                      decoration:
                          textDecorationemail.copyWith(hintText: "Name"),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //dropdown
                    DropdownButtonFormField(
                      decoration: textDecorationemail,
                      value: _currentSugar ?? userData.sugars,
                      onChanged: (val) {
                        setState(() => _currentSugar = val);
                      },
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          child: Text("$sugar sugars"),
                          value: sugar,
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //slider
                    Slider(
                        activeColor: Colors
                            .brown[(_currentStrength ?? userData.strength)],
                        inactiveColor: Colors
                            .brown[(_currentStrength ?? userData.strength)],
                        min: 100,
                        max: 900,
                        divisions: 8,
                        value:
                            (_currentStrength ?? userData.strength).toDouble(),
                        onChanged: (val) =>
                            setState(() => _currentStrength = val.round())),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown[700], onPrimary: Colors.white),
                      onPressed: () async {
                        print(_currentSugar);
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: wrapperUser.uid)
                              .updateUserData(
                                  _currentSugar ?? userData.sugars,
                                  _currentName ?? userData.name,
                                  _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Update"),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
