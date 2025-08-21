import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
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

  Future<void> createAccount(
    String name,
    String email,
    String pw,
    Uint8List image,
    String imageName,
  ) async {
    try {
      // creating account
      await _auth.createUserWithEmailAndPassword(email: email, password: pw);

      await supabase.storage
          .from('user_profile_pic')
          .uploadBinary('profile_pic/$imageName', image);

      String userId = _auth.currentUser!.uid;
      // get link from supabase
      String imageUrl = supabase.storage
          .from('user_profile_pic')
          .getPublicUrl('profile_pic/$imageName');

      // saving user data in the firestore

      _db.collection('users').doc(userId).set({
        'id': userId,
        'name': name,
        'email': email,
        'profile_pic': imageUrl,
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
  Future<void> deleteUser(String userId) async {
    try {
      // 1. Get product data from Firestore
      var doc = await _db.collection('users').doc(userId).get();

      if (!doc.exists) {
        throw Exception("Product not found");
      }

      var data = doc.data()!;
      String imageUrl = data['profile_pic'];

      // 2. Extract path from Supabase public URL
      Uri uri = Uri.parse(imageUrl);
      String path = uri.pathSegments.sublist(5).join('/');
      // "storage/v1/object/public/products/" → skip 4 segments

      if (data['profile_pic'] != null) {
        // 3. Delete image from Supabase
        await supabase.storage.from('user_profile_pic').remove([path]);
      }
      // 4. Delete Firestore document
      await _db.collection('users').doc(userId).delete();

      final currentUser = _auth.currentUser;
      if (currentUser != null && currentUser.uid == userId) {
        await currentUser.delete();
      }
    } on FirebaseException catch (e) {
      throw getMessageFromErrorCode(e.code);
    }
  }
}
