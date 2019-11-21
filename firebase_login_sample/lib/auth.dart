import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {

  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 Future<String> signInWithEmailAndPassword(String email, String password) async {
     AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     FirebaseUser user = result.user;

     return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    AuthResult result =   await _firebaseAuth.createUserWithEmailAndPassword(email:email, password: password);
     FirebaseUser user = result.user;

     return user.uid;
  }

<<<<<<< HEAD
  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }
=======
   Future<String> currentUser() async {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return user != null ? user.uid : null;
    }
>>>>>>> ec34cdbb2f15892edfb586a1317d890a641a2b34

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

}