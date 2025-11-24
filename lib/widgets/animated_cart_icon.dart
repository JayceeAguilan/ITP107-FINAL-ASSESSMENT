import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import '../providers/cart_provider.dart';

class AnimatedCartIcon extends StatefulWidget {
  const AnimatedCartIcon({super.key});

  @override
  State<AnimatedCartIcon> createState() => _AnimatedCartIconState();
}

class _AnimatedCartIconState extends State<AnimatedCartIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _previousItemCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        if (cart.itemCount > _previousItemCount) {
          _controller.forward(from: 0.0);
        }
        _previousItemCount = cart.itemCount;

        return ScaleTransition(
          scale: _scaleAnimation,
          child: IconButton(
            onPressed: () => context.go('/cart'),
            icon: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -5),
              showBadge: cart.itemCount > 0,
              badgeContent: Text(
                cart.itemCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        );
      },
    );
  }
}
