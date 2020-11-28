import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app1/models/brew.dart';
import 'package:firebase_app1/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference mean reference to particular collection in firebase db.
  //if this collection 'brews' doesnt exist in FB db then it will automatically create new collection
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String name, String sugars, int strength) async {
    return await brewCollection.document(uid).setData({
      //if this doc doesn't exist fb will create doc with this uid
      'name': name,
      'sugars': sugars,
      'strength': strength
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ??
            '0', //if doc.data returns null we store '0' to avoid error
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  //get brews stream = means getting upto date data of brews collection through stream and mapping it to our custom brew
  Stream<List<Brew>> get brewsSnapshot {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //for mapping userdata from snapshot to our custom class UserData
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
      );
  }

  //get specific user doc stream and mapping to our custom Userdata
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
