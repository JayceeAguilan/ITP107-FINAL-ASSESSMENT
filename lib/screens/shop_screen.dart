import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';
import '../widgets/filter_drawer.dart';
import '../utils/constants.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > AppConstants.mobileBreakpoint;
    final isDesktop = MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint;

    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const FilterDrawer(),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
                child: Row(
                  children: [
                    // Filter Button
                    OutlinedButton.icon(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filters'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Search Bar
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onChanged: (value) {
                          Provider.of<ProductProvider>(context, listen: false).setSearchQuery(value);
                        },
                      ),
                    ),
                    
                    if (isLargeScreen) ...[
                      const SizedBox(width: 16),
                      // Sort Dropdown
                      Consumer<ProductProvider>(
                        builder: (context, provider, _) {
                          return DropdownButton<String>(
                            value: 'popularity', // TODO: Get from provider
                            underline: Container(),
                            icon: const Icon(Icons.sort),
                            items: const [
                              DropdownMenuItem(value: 'popularity', child: Text('Popularity')),
                              DropdownMenuItem(value: 'newest', child: Text('Newest')),
                              DropdownMenuItem(value: 'price_asc', child: Text('Price: Low to High')),
                              DropdownMenuItem(value: 'price_desc', child: Text('Price: High to Low')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                provider.setSortBy(value);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          
          const Divider(height: 1),

          // Product Grid
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                final products = provider.products;

                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => provider.clearFilters(),
                          child: const Text('Clear Filters'),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isDesktop ? 4 : (isLargeScreen ? 3 : 1),
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return ProductCard(product: products[index]);
                              },
                            ),
                          ),
                        ),
                      ),
                      const Footer(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
