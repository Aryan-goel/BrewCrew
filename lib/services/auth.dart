import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:brew_crew/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Useruid _userFromUser(User user) {
    return user != null ? Useruid(uid: user.uid) : null;
  }

  Stream<Useruid> get firebaseuser {
    return _auth
        .authStateChanges() //.onauthstatechanges is depresiated so we use this
        .map(_userFromUser);
  }

// to sign in anonomusly
  Future signinAnon() async {
    try {
      UserCredential credential = await _auth
          .signInAnonymously(); //*AuthResult changed to UserCredential
      User user = credential.user; //*FirebaseUser changed to User*//
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with wmail and password
  Future signInWithEmailAndPass(String email, String password) async {
    try {
      UserCredential creds = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User rUser = creds.user;

      return _userFromUser(rUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//*register with email id
  Future registerWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User rUser = result.user;
      await DatabaseService(uid: rUser.uid).updateUserData('0', "user", 100);
      return _userFromUser(rUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //* to sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
