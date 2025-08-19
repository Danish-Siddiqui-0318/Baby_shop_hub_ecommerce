import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  SupabaseClient supabase = Supabase.instance.client;

  FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  // add product

  Future<void> addProduct(
    Uint8List image,
    String imageName,
    String title,
    double price,
    String category,
    String desc,
  ) async {
    try {
      await supabase.storage
          .from('products')
          .uploadBinary('images/$imageName', image);

      // get link from supabase
      String imageUrl = await supabase.storage
          .from('products')
          .getPublicUrl('images/$imageName');

      // generate id for product

      var uuid = Uuid();
      String productId = uuid.v1();

      // save data in firestore

      _db.collection('products').doc(productId).set({
        'id': productId,
        'imageUrl': imageUrl,
        'title': title,
        'price': price,
        'category': category,
        'desc': desc,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  // get products
  Stream<List<Map<String, dynamic>>> getProducts() {
    return _db.collection('products').snapshots().asyncMap((snapshot) {
      List<Map<String, dynamic>> productList = [];
      for (var doc in snapshot.docs) {
        productList.add(doc.data());
      }
      return productList;
    });
  }

  // delete product
  Future<void> deleteProduct(String productId) async {
    try {
      // 1. Get product data from Firestore
      var doc = await _db.collection('products').doc(productId).get();

      if (!doc.exists) {
        throw Exception("Product not found");
      }

      var data = doc.data()!;
      String imageUrl = data['imageUrl'];

      // 2. Extract path from Supabase public URL
      // Example URL: https://xyz.supabase.co/storage/v1/object/public/products/images/abc.png
      // Path we need: images/abc.png
      Uri uri = Uri.parse(imageUrl);
      String path = uri.pathSegments.sublist(5).join('/');
      // "storage/v1/object/public/products/" → skip 4 segments

      // 3. Delete image from Supabase
      await supabase.storage.from('products').remove([path]);

      // 4. Delete Firestore document
      await _db.collection('products').doc(productId).delete();
    } catch (e) {
      throw Exception("Error deleting product: $e");
    }
  }
}
