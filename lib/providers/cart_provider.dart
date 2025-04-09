import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {}; // Key: product.id

  Map<int, CartItem> get items => _items;

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += 1;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items.remove(product.id);
      notifyListeners();
    }
  }

  void increaseQuantity(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(Product product) {
    if (_items.containsKey(product.id)) {
      final item = _items[product.id]!;
      if (item.quantity > 1) {
        item.quantity -= 1;
      } else {
        _items.remove(product.id);
      }
      notifyListeners();
    }
  }

  int get itemCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.values
      .fold(0, (sum, item) => sum + item.quantity * item.product.price);

  bool isInCart(Product product) {
    return _items.containsKey(product.id);
  }
}
