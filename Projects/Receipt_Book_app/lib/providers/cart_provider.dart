// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Set<String> _cartItems = {};

  Set<String> get cartItems => _cartItems;

  void addToCart(String recipeId) {
    _cartItems.add(recipeId);
    notifyListeners();
  }

  void removeFromCart(String recipeId) {
    _cartItems.remove(recipeId);
    notifyListeners();
  }

  bool isInCart(String recipeId) => _cartItems.contains(recipeId);

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
