import 'package:flutter/material.dart';
import 'package:khemputhsela_store/cart_list.dart';
import 'package:khemputhsela_store/product.dart';

class HandlerCart with ChangeNotifier {
  Map<String, CartList> _items = {};

  Map<String, CartList> get items => _items;

  double get totalAmount {
    return _items.values.fold(
      0,
          (sum, item) => sum + item.price * item.qty,
    );
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id.toString())) {
      _items.update(
        product.id.toString(),
            (existingItem) => CartList(
          id: existingItem.id,
          product: existingItem.product,
          qty: existingItem.qty + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id.toString(),
            () => CartList(
          id: DateTime.now().toString(),
          product: product,
          qty: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeOneItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.qty > 1) {
      _items.update(
        productId,
            (existingItem) => CartList(
          id: existingItem.id,
          product: existingItem.product,
          qty: existingItem.qty - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
