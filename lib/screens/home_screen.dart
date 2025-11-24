import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/product_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';
import '../widgets/skeleton_loader.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > AppConstants.mobileBreakpoint;
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            _buildHeroSection(context, isLargeScreen),

            const SizedBox(height: 60),

            // Categories Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    'Shop by Category',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  _isLoading 
                      ? _buildCategoriesSkeleton(isLargeScreen)
                      : _buildCategoriesGrid(context, productProvider, isLargeScreen),
                ],
              ),
            ),

            const SizedBox(height: 80),

            // Featured Products Section
            Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: isLargeScreen
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Featured Collections',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: TextButton(
                                  onPressed: () {
                                    productProvider.clearFilters();
                                    context.go('/shop');
                                  },
                                  child: const Row(
                                    children: [
                                      Text('View All'),
                                      SizedBox(width: 4),
                                      Icon(Icons.arrow_forward, size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                'Featured Collections',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () {
                                  productProvider.clearFilters();
                                  context.go('/shop');
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('View All'),
                                    SizedBox(width: 4),
                                    Icon(Icons.arrow_forward, size: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 32),
                  _isLoading
                      ? _buildFeaturedSkeleton(isLargeScreen)
                      : _buildFeaturedProducts(context, productProvider, isLargeScreen),
                ],
              ),
            ),

            const SizedBox(height: 80),

            // New Arrivals Banner
            _buildPromoBanner(context, isLargeScreen),

            const SizedBox(height: 80),

            // New Arrivals Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    'New Arrivals',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  _isLoading
                      ? _buildNewArrivalsSkeleton(isLargeScreen)
                      : _buildNewArrivalsGrid(context, productProvider, isLargeScreen),
                  const SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () {
                      productProvider.clearFilters();
                      context.go('/shop');
                    },
                    child: const Text('Shop All New Arrivals'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isLargeScreen) {
    final List<String> heroImages = [
      'https://images.unsplash.com/photo-1556906781-9a412961c28c?q=80&w=2070&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop', // Red Nike
      'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?q=80&w=1964&auto=format&fit=crop', // Green Nike
      'https://images.unsplash.com/photo-1560769629-975ec94e6a86?q=80&w=1964&auto=format&fit=crop', // Dress Shoes
      'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?q=80&w=1974&auto=format&fit=crop', // Running Shoes
      'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=2070&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?q=80&w=2070&auto=format&fit=crop',
    ];

    return SizedBox(
      height: isLargeScreen ? 600 : 500,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: CarouselSlider(
              options: CarouselOptions(
                height: isLargeScreen ? 600 : 500,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollPhysics: const NeverScrollableScrollPhysics(), // Optional: disable manual scrolling if desired, but usually users like to scroll
              ),
              items: heroImages.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        color: Colors.black.withValues(alpha: 0.3),
                        colorBlendMode: BlendMode.darken,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Elevate Your Style',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: isLargeScreen ? 72 : 48,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Discover the perfect blend of comfort and fashion with our exclusive collection.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: isLargeScreen ? 20 : 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<ProductProvider>(context, listen: false).clearFilters();
                        context.go('/shop');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      ),
                      child: const Text('Shop Now'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSkeleton(bool isLargeScreen) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isLargeScreen ? 5 : 2,
          childAspectRatio: isLargeScreen ? 0.8 : 1.0,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SkeletonBase(width: 64, height: 64, borderRadius: 32),
                SizedBox(height: 16),
                SkeletonBase(width: 80, height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context, ProductProvider provider, bool isLargeScreen) {
    final categories = provider.categories;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isLargeScreen ? 5 : 2,
          childAspectRatio: isLargeScreen ? 0.8 : 1.0,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: () {
              provider.setCategory(category.id);
              context.go('/shop');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      category.icon,
                      size: 32,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSkeleton(bool isLargeScreen) {
    if (isLargeScreen) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: List.generate(3, (index) {
                return const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 350,
                      child: SkeletonProductCard(),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 380,
        viewportFraction: 0.75,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
      items: List.generate(3, (index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SkeletonProductCard(),
        );
      }),
    );
  }

  Widget _buildFeaturedProducts(BuildContext context, ProductProvider provider, bool isLargeScreen) {
    final featured = provider.featuredProducts;
    
    if (isLargeScreen) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: featured.take(3).map((product) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 350, // Fixed height for consistency
                      child: ProductCard(product: product),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 380,
        viewportFraction: 0.75,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
      items: featured.map((product) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ProductCard(product: product),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildPromoBanner(BuildContext context, bool isLargeScreen) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1460353581641-37baddab0fa2?q=80&w=2071&auto=format&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withValues(alpha: 0.8),
              Colors.transparent,
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(
                    flex: isLargeScreen ? 1 : 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LIMITED OFFER',
                          style: TextStyle(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Summer Sale\nUp to 50% Off',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: isLargeScreen ? 56 : 40,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Grab your favorites before they are gone. Free shipping on all orders over \$100.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<ProductProvider>(context, listen: false).clearFilters();
                            context.go('/shop');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentColor,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Shop Sale'),
                        ),
                      ],
                    ),
                  ),
                  if (isLargeScreen) const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewArrivalsSkeleton(bool isLargeScreen) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isLargeScreen ? 4 : 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const SkeletonProductCard();
        },
      ),
    );
  }

  Widget _buildNewArrivalsGrid(BuildContext context, ProductProvider provider, bool isLargeScreen) {
    final newArrivals = provider.newArrivals;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isLargeScreen ? 4 : 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: newArrivals.length,
        itemBuilder: (context, index) {
          return ProductCard(product: newArrivals[index]);
        },
      ),
    );
  }
}
