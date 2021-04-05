import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

//for collextion refrence
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({"sugar": sugars, "name": name, "strength": strength});
  }

  //list of brews

  List<Brew> _brewListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.data()['name'] ?? " ",
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugar'] ?? '0',
      );
    }).toList();
  }

//* user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'], //* the data function need () to now
        sugars: snapshot.data()['sugar'],
        strength: snapshot.data()['strength']);
  }

// brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshots);
  }

//*user data doc

  Stream<UserData> get userdata {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
