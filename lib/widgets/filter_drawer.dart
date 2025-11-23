import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../theme/app_theme.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  return ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      // Categories
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...provider.categories.map((category) {
                        // This is a simplification. In a real app, you'd check if this category is selected
                        // Here we are just showing them as options
                        return CheckboxListTile(
                          title: Text(category.name),
                          value: false, // TODO: Link to provider state
                          onChanged: (bool? value) {
                            provider.setCategory(value == true ? category.id : null);
                            Navigator.pop(context);
                          },
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                        );
                      }),

                      const SizedBox(height: 24),

                      // Price Range
                      Text(
                        'Price Range',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RangeSlider(
                        values: provider.priceRange,
                        min: 0,
                        max: 100000,
                        divisions: 100,
                        labels: RangeLabels(
                          '\u20B1${provider.priceRange.start.round()}',
                          '\u20B1${provider.priceRange.end.round()}',
                        ),
                        activeColor: AppTheme.primaryColor,
                        onChanged: (RangeValues values) {
                          provider.setPriceRange(values);
                        },
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\u20B10'),
                          Text('\u20B1100,000'),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Clear Filters Button
                      OutlinedButton(
                        onPressed: () {
                          provider.clearFilters();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear All Filters'),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Show Results'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
