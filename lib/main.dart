import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
// Will import real screens as they are implemented
// import 'screens/home_screen.dart';
// import 'screens/shop_screen.dart';
// import 'screens/product_detail_screen.dart';
// import 'screens/cart_screen.dart';
// import 'screens/checkout_screen.dart';
// import 'screens/about_screen.dart';
// import 'screens/contact_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp.router(
        title: 'UrbanKicks',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/welcome',
  routes: [
    GoRoute(
      path: '/welcome',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context, 
        state: state, 
        child: const WelcomeScreen(),
      ),
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context, 
        state: state, 
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/shop',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context, 
        state: state, 
        child: const ShopScreen(),
      ),
    ),
    GoRoute(
      path: '/product/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return _buildPageWithTransition(
          context: context, 
          state: state, 
          child: ProductDetailScreen(productId: id),
        );
      },
    ),
    GoRoute(
      path: '/cart',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context, 
        state: state, 
        child: const CartScreen(),
      ),
    ),
    GoRoute(
      path: '/checkout',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context, 
        state: state, 
        child: const CheckoutScreen(),
      ),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context, 
        state: state, 
        child: const AboutScreen(),
      ),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context, 
        state: state, 
        child: const ContactScreen(),
      ),
    ),
  ],
);

CustomTransitionPage _buildPageWithTransition({
  required BuildContext context, 
  required GoRouterState state, 
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
