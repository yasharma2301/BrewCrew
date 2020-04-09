import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class authService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
//sign in email/pass
  Future signInWithEmail(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser u=result.user;
      if(u==null){
        return null;
      }
      return _userFromFirebaseUser(u);
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }



//reg with email/pass
  Future registerWithEmail(String email,String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser u=result.user;
      await DatabaseService(uid: u.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(u);
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }



//signout
Future signout() async{
    try{
      return await _auth.signOut();
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
}
}
