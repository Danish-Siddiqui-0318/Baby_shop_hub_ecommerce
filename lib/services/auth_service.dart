import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/exception_handler.dart';

class AuthService {
  //for authentication
  FirebaseAuth _auth = FirebaseAuth.instance;

  // firebase database

  FirebaseFirestore _db = FirebaseFirestore.instance;

  //supabse
  SupabaseClient supabase = Supabase.instance.client;

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
        'profile_pic': null,
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

  Future<void> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      throw getMessageFromErrorCode(e.code);
    }
  }

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

  // get All Users

  Stream<List<Map<String, dynamic>>> getAllUsers() {
    return _db.collection('users').snapshots().asyncMap((snapshot) {
      List<Map<String, dynamic>> usersList = [];
      for (var doc in snapshot.docs) {
        usersList.add(doc.data());
      }
      return usersList;
    });
  }

  // delete a User
  Future<void> deleteUser(String productId) async {
    try {
      // 1. Get product data from Firestore
      var doc = await _db.collection('users').doc(productId).get();

      if (!doc.exists) {
        throw Exception("Product not found");
      }

      var data = doc.data()!;
      String imageUrl = data['profile_pic'];

      // 2. Extract path from Supabase public URL
      // Example URL: https://xyz.supabase.co/storage/v1/object/public/products/images/abc.png
      // Path we need: images/abc.png
      Uri uri = Uri.parse(imageUrl);
      String path = uri.pathSegments.sublist(5).join('/');
      // "storage/v1/object/public/products/" → skip 4 segments

      print("Deleting path: $path");

      if (data['profile_pic'] != null) {
        // 3. Delete image from Supabase
        print("Deleting path: $path");
        await supabase.storage.from('user_profile_pic').remove([path]);
        print("im here");
      }else{
        print("This is Empty");
      }
      // 4. Delete Firestore document
      await _db.collection('users').doc(productId).delete();
    } on FirebaseException catch (e) {
      throw getMessageFromErrorCode(e.code);
    }
  }
}
