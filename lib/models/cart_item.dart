import 'product.dart';

class CartItem {
  final String id;
  final Product product;
  final double selectedSize;
  final String selectedColor;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CartItem &&
      other.product.id == product.id &&
      other.selectedSize == selectedSize &&
      other.selectedColor == selectedColor;
  }

  @override
  int get hashCode => Object.hash(product.id, selectedSize, selectedColor);
}
