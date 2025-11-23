import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  double? _selectedSize;
  String? _selectedColor;
  int _quantity = 1;
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context).findById(widget.productId);
    final isLargeScreen = MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Breadcrumbs
            Container(
              width: double.infinity,
              color: Colors.grey[100],
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => context.go('/'),
                        child: const Text('Home', style: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => context.go('/shop'),
                        child: const Text('Shop', style: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Product Content
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: isLargeScreen
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: _buildImageGallery(product)),
                            const SizedBox(width: 60),
                            Expanded(flex: 2, child: _buildProductInfo(context, product)),
                          ],
                        )
                      : Column(
                          children: [
                            _buildImageGallery(product),
                            const SizedBox(height: 40),
                            _buildProductInfo(context, product),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(height: 80),

            // Related Products
            _buildRelatedProducts(context, product),

            const SizedBox(height: 80),

            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery(Product product) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 500,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
          items: product.images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: product.images.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                    .withValues(alpha: _currentImageIndex == entry.key ? 0.9 : 0.2),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.brand.toUpperCase(),
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.name,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            RatingBarIndicator(
              rating: product.rating,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
            const SizedBox(width: 8),
            Text(
              '(${product.reviewCount} reviews)',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          '\u20B1${product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          product.description,
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 32),
        
        // Size Selection
        const Text(
          'Select Size',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: product.sizes.map((size) {
            final isSelected = _selectedSize == size;
            return InkWell(
              onTap: () => setState(() => _selectedSize = size),
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryColor : Colors.white,
                  border: Border.all(
                    color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  size.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // Color Selection
        const Text(
          'Select Color',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: product.colors.map((color) {
            final isSelected = _selectedColor == color;
            return InkWell(
              onTap: () => setState(() => _selectedColor = color),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(int.parse(color.replaceAll('#', '0xFF'))),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
                    width: isSelected ? 3 : 1,
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 40),

        // Add to Cart & Quantity
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_quantity > 1) setState(() => _quantity--);
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() => _quantity++);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: (_selectedSize != null && _selectedColor != null)
                      ? () {
                          Provider.of<CartProvider>(context, listen: false).addItem(
                            product,
                            _selectedSize!,
                            _selectedColor!,
                            _quantity,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${product.name} to cart'),
                              action: SnackBarAction(
                                label: 'VIEW CART',
                                onPressed: () => context.go('/cart'),
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
            ),
          ],
        ),
        if (_selectedSize == null || _selectedColor == null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Please select size and color',
              style: TextStyle(color: AppTheme.errorColor, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildRelatedProducts(BuildContext context, Product currentProduct) {
    final relatedProducts = Provider.of<ProductProvider>(context)
        .findByCategory(currentProduct.categoryId)
        .where((p) => p.id != currentProduct.id)
        .take(4)
        .toList();

    if (relatedProducts.isEmpty) return const SizedBox.shrink();

    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Text(
            'You May Also Like',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 40),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: relatedProducts.map((product) {
                  return SizedBox(
                    width: 280,
                    height: 380,
                    child: ProductCard(product: product),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
