import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../providers/cart_provider.dart';
import '../widgets/animated_cart_icon.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > AppConstants.mobileBreakpoint;
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      automaticallyImplyLeading: !isLargeScreen,
      titleSpacing: isLargeScreen ? null : 8,
      title: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => context.go('/'),
          child: Text(
            'UrbanKicks',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w800,
              fontSize: isLargeScreen ? null : (screenWidth < 400 ? 18 : 20),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      actions: [
        if (isLargeScreen) ...[ 
          _NavItem(title: 'Home', onTap: () => context.go('/')),
          _NavItem(title: 'Shop', onTap: () => context.go('/shop')),
          _NavItem(title: 'About', onTap: () => context.go('/about')),
          _NavItem(title: 'Contact', onTap: () => context.go('/contact')),
          const SizedBox(width: 8),
        ],
        
        IconButton(
          icon: const Icon(Icons.search),
          iconSize: isLargeScreen ? 24 : 20,
          padding: EdgeInsets.all(isLargeScreen ? 8 : 4),
          constraints: const BoxConstraints(),
          onPressed: () {
            context.go('/shop');
            // Ideally focus search field
          },
        ),
        
        const AnimatedCartIcon(),
        
        SizedBox(width: isLargeScreen ? 16 : 8),
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
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
