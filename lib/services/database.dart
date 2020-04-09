import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference cr = Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await cr.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  Stream<List<Brew>> get brews {
    return cr.snapshots().map(_brewListFromSnapshots);
  }

  //brew list from snaps
  List<Brew> _brewListFromSnapshots(QuerySnapshot snap) {
    return snap.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          sugars: doc.data['sugars'] ?? '0',
          strength: doc.data['strength'] ?? 0);
    }).toList();
  }

//user doc stream
  Stream<UserData> get userData {
    return cr.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  //user data from snaps
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }
}
