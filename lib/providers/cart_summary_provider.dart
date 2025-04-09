import 'package:flutter/material.dart';
import 'cart_provider.dart';

class CartSummaryProvider with ChangeNotifier {
  int totalItems = 0;
  double totalPrice = 0;

  void updateFromCart(CartProvider cart) {
    totalItems = cart.itemCount;
    totalPrice = cart.totalPrice;
    notifyListeners();
  }
}
