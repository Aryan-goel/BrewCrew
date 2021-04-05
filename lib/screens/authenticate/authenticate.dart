import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signIn = true;
  void toggleview() {
    setState(() => signIn = !signIn);
  }

  @override
  Widget build(BuildContext context) {
    if (signIn) {
      return SignIn(toggle: toggleview);
    } else {
      return Register(toggle: toggleview);
    }
  }
}
