import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
        initialData: [],
        value: DatabaseService().brews,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.brown[900],
            elevation: 10,
            actions: [
              ElevatedButton.icon(
                onPressed: () async {
                  await _auth.signout();
                },
                icon: Icon(Icons.person),
                label: Text("signout"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.brown[900], onPrimary: Colors.white),
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.brown[900], onPrimary: Colors.white),
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings),
                  label: Text("Settings"))
            ],
          ),
          body: Container(
            child: BrewList(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/coffee3.png'),
                    fit: BoxFit.cover)),
          ),
        ));
  }
}
