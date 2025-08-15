import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../utils/exception_handler.dart';

class AuthService {
  //for authentication
  FirebaseAuth _auth = FirebaseAuth.instance;

  // firebase database

  FirebaseFirestore _db = FirebaseFirestore.instance;

  // create account

  Future<void> createAccount(String name, email, pw) async {
    try {
      // creating account
      await _auth.createUserWithEmailAndPassword(email: email, password: pw);

      String userId = _auth.currentUser!.uid;

      // saving user data in the firestore

      await _db.collection('users').doc(userId).set({
        'id': userId,
        'name': name,
        'email': email,
      });

      // print("Account Created");
    } on FirebaseException catch (e) {
      throw getMessageFromErrorCode(e.code);
    }
  }

  // sign in

  Future<void> login(String email, pw) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: pw)
          .timeout(Duration(seconds: 25));
      print("login success");
    } on FirebaseException catch (e) {
      print(getMessageFromErrorCode(e.toString()));
    }
  }

  // sign out

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseException catch (e) {
      throw getMessageFromErrorCode(e.code);
    }
    ;
  }

  //forget password

  // get user details
  Future<Map<String, dynamic>?> getUsersDetails() async {
    try {
      var userDoc = await _db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      return userDoc.data();
    } on FirebaseException catch (e) {
      throw e.message ?? "Something went wrong";
    }
  }
}
