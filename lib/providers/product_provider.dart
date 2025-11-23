import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../utils/sample_data.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = SampleData.products;
  List<Category> _categories = SampleData.categories;
  
  // Filter state
  String _searchQuery = '';
  String? _selectedCategory;
  RangeValues _priceRange = const RangeValues(0, 100000);
  String _sortBy = 'popularity'; // price_asc, price_desc, newest, popularity

  List<Product> get products {
    List<Product> filtered = [..._products];

    // Apply Search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((prod) => 
        prod.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
        prod.brand.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    // Apply Category Filter
    if (_selectedCategory != null) {
      filtered = filtered.where((prod) => prod.categoryId == _selectedCategory).toList();
    }

    // Apply Price Filter
    filtered = filtered.where((prod) => 
      prod.price >= _priceRange.start && prod.price <= _priceRange.end
    ).toList();

    // Apply Sorting
    switch (_sortBy) {
      case 'price_asc':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_desc':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'newest':
        filtered.sort((a, b) => (b.isNew ? 1 : 0).compareTo(a.isNew ? 1 : 0));
        break;
      case 'popularity':
      default:
        filtered.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
    }

    return filtered;
  }

  List<Category> get categories => [..._categories];
  
  List<Product> get featuredProducts => _products.where((p) => p.isPopular).take(5).toList();
  
  List<Product> get newArrivals => _products.where((p) => p.isNew).take(5).toList();

  RangeValues get priceRange => _priceRange;

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }
  
  List<Product> findByCategory(String categoryId) {
    return _products.where((prod) => prod.categoryId == categoryId).toList();
  }

  // Filter Actions
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String? categoryId) {
    _selectedCategory = categoryId;
    notifyListeners();
  }

  void setPriceRange(RangeValues range) {
    _priceRange = range;
    notifyListeners();
  }

  void setSortBy(String sort) {
    _sortBy = sort;
    notifyListeners();
  }
  
  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _priceRange = const RangeValues(0, 100000);
    _sortBy = 'popularity';
    notifyListeners();
  }
}
