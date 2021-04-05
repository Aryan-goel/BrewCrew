import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/icon.png'),
            radius: 20,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(
            brew.name,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          subtitle: Text(
            "takes ${brew.sugars} sugar(s)",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
