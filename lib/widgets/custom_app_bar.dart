import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > AppConstants.mobileBreakpoint;

    return AppBar(
      title: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => context.go('/'),
          child: Text(
            'UrbanKicks',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      actions: [
        if (isLargeScreen) ...[
          _NavItem(title: 'Home', onTap: () => context.go('/')),
          _NavItem(title: 'Shop', onTap: () => context.go('/shop')),
          _NavItem(title: 'About', onTap: () => context.go('/about')),
          _NavItem(title: 'Contact', onTap: () => context.go('/contact')),
          const SizedBox(width: 16),
        ],
        
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.go('/shop');
            // Ideally focus search field
          },
        ),
        
        Consumer<CartProvider>(
          builder: (context, cart, child) {
            return IconButton(
              icon: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -10, end: -5),
                showBadge: cart.itemCount > 0,
                badgeContent: Text(
                  cart.itemCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: AppTheme.accentColor,
                ),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              onPressed: () => context.go('/cart'),
            );
          },
        ),
        
        const SizedBox(width: 16),
        
        if (!isLargeScreen)
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
