import 'package:baby_shop_hub/services/product_service.dart';
import 'package:flutter/material.dart';


enum ProductState { idle, loading, loaded, error }

class ProductProvider extends ChangeNotifier {

  ProductProvider(){
    fetchProducts();
  }


  List<Map<String,dynamic>> _products = [];

  ProductState _state = ProductState.idle;
  
  String _errorMessage = '';
  
  ProductService _productService = ProductService();



  List<Map<String,dynamic>> get products => _products;
  ProductState get state => _state;
  String get errorMessage => _errorMessage;


  Future<void> fetchProducts() async {
    try {
      _state = ProductState.loading;
      notifyListeners();

      _products = await _productService.getProducts();

      _state = ProductState.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _state = ProductState.error;
      notifyListeners();
    }
  }



  
  // Your product-related state and methods go here
}