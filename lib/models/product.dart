class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final List<double> sizes;
  final List<String> colors; // Hex codes or color names
  final String categoryId;
  final String brand;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final bool isPopular;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.categoryId,
    required this.brand,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isNew = false,
    this.isPopular = false,
  });

  // Helper to get main image
  String get mainImage => images.isNotEmpty ? images.first : '';
}
