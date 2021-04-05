import 'package:brew_crew/loading.dart';
//import 'package:brew_crew/screens/authenticate/signin.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import "package:brew_crew/services/auth.dart";

class Register extends StatefulWidget {
  final Function toggle;
  Register({this.toggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[200],
            appBar: AppBar(
              backgroundColor: Colors.brown[900],
              elevation: 10,
              title: Text("Register"),
              centerTitle: true,
              actions: <Widget>[
                ElevatedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Signin"),
                  onPressed: () {
                    widget.toggle();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.brown[900], onPrimary: Colors.white),
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration:
                              textDecorationemail.copyWith(hintText: "Email"),
                          validator: (val) =>
                              val.isEmpty ? "Enter an email" : null,
                          style: TextStyle(fontSize: 20),
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textDecorationpassword.copyWith(
                              hintText: "Password"),
                          validator: (pass) => pass.length < 6
                              ? "Enter a longer password"
                              : null,
                          style: TextStyle(fontSize: 20),
                          obscureText: true,
                          onChanged: (pass) {
                            setState(() => password = pass);
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              setState(() => loading = true);
                              print(email);
                              print(password);
                              dynamic result = await _auth
                                  .registerWithEmailAndPass(email, password);

                              if (result == null) {
                                setState(() =>
                                    error = "please provide an valid email id");
                                loading = false;
                              }
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.brown[500],
                              onPrimary: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          error,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )
                      ],
                    ))));
  }
}
