import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryColor.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UrbanKicks',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Elevate Your Style',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: [
                _DrawerItem(
                  icon: Icons.home_outlined,
                  title: 'Home',
                  isSelected: currentRoute == '/',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/');
                  },
                ),
                _DrawerItem(
                  icon: Icons.shopping_bag_outlined,
                  title: 'Shop',
                  isSelected: currentRoute == '/shop',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/shop');
                  },
                ),
                _DrawerItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  isSelected: currentRoute == '/about',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/about');
                  },
                ),
                _DrawerItem(
                  icon: Icons.contact_mail_outlined,
                  title: 'Contact',
                  isSelected: currentRoute == '/contact',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/contact');
                  },
                ),
                const Divider(height: 24, thickness: 1),
                _DrawerItem(
                  icon: Icons.shopping_cart_outlined,
                  title: 'Cart',
                  isSelected: currentRoute == '/cart',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/cart');
                  },
                ),
              ],
            ),
          ),
          
          // Footer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '© 2024 UrbanKicks',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: isSelected 
            ? AppTheme.primaryColor.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        leading: Icon(
          icon,
          color: isSelected ? AppTheme.primaryColor : Colors.grey[700],
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryColor : Colors.grey[900],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
