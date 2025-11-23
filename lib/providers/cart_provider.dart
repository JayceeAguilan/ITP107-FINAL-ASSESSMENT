import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../utils/constants.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get subtotal {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.totalPrice;
    });
    return total;
  }

  double get taxAmount => subtotal * AppConstants.taxRate;

  double get totalAmount => subtotal + taxAmount;

  void addItem(Product product, double size, String color, int quantity) {
    // Create a unique key based on product id, size and color
    final cartKey = '${product.id}_${size}_$color';

    if (_items.containsKey(cartKey)) {
      // Update quantity if item already exists
      _items.update(
        cartKey,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          product: existingCartItem.product,
          selectedSize: existingCartItem.selectedSize,
          selectedColor: existingCartItem.selectedColor,
          quantity: existingCartItem.quantity + quantity,
        ),
      );
    } else {
      // Add new item
      _items.putIfAbsent(
        cartKey,
        () => CartItem(
          id: DateTime.now().toString(),
          product: product,
          selectedSize: size,
          selectedColor: color,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId, double size, String color) {
    final cartKey = '${productId}_${size}_$color';
    _items.remove(cartKey);
    notifyListeners();
  }

  void updateQuantity(String productId, double size, String color, int quantity) {
    final cartKey = '${productId}_${size}_$color';
    if (!_items.containsKey(cartKey)) return;

    if (quantity <= 0) {
      removeItem(productId, size, color);
      return;
    }

    _items.update(
      cartKey,
      (existingCartItem) => CartItem(
        id: existingCartItem.id,
        product: existingCartItem.product,
        selectedSize: existingCartItem.selectedSize,
        selectedColor: existingCartItem.selectedColor,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
