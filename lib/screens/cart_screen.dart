import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/navigation_drawer.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const NavigationDrawerWidget(),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.itemCount == 0) {
            return _buildEmptyCart(context);
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shopping Cart (${cart.itemCount} items)',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 24),
                        if (isLargeScreen)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: _buildCartList(cart),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                flex: 1,
                                child: _buildOrderSummary(context, cart),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              _buildCartList(cart),
                              const SizedBox(height: 24),
                              _buildOrderSummary(context, cart),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                const Footer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return EmptyStateWidget(
      title: 'Your cart is empty',
      description: 'Looks like you haven\'t added any items to your cart yet.',
      icon: Icons.shopping_cart_outlined,
      buttonText: 'Start Shopping',
      onButtonPressed: () => context.go('/shop'),
    );
  }

  Widget _buildCartList(CartProvider cart) {
    return Column(
      children: cart.items.values.map((item) => CartItemWidget(cartItem: item)).toList(),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartProvider cart) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildSummaryRow('Subtotal', '\u20B1${cart.subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            _buildSummaryRow('Tax (8%)', '\u20B1${cart.taxAmount.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            _buildSummaryRow('Shipping', 'Free'),
            const Divider(height: 32),
            _buildSummaryRow(
              'Total',
              '\u20B1${cart.totalAmount.toStringAsFixed(2)}',
              isTotal: true,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => context.go('/checkout'),
                child: const Text('Proceed to Checkout'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => context.go('/shop'),
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppTheme.primaryColor : Colors.black,
          ),
        ),
      ],
    );
  }
}
