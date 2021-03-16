import 'package:flutter/foundation.dart';

import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _items = {}; //products in cart

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    _items.update(
      productId,
      (existingCartItem) => Cart(
        id: existingCartItem.id,
        title: existingCartItem.title,
        price: existingCartItem.price,
        quantity: existingCartItem.quantity + 1,
      ),
      ifAbsent: () => Cart(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void undo(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => Cart(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
