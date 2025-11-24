import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Banner
            Container(
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1556906781-9a412961c28c?q=80&w=2070&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withValues(alpha: 0.6),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Our Story',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: isLargeScreen ? 64 : 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Redefining Footwear Since 2025',
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 80),

            // Mission Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    Text(
                      'Our Mission',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'At UrbanKicks, we believe that great footwear is the foundation of every great journey. Our mission is to provide premium quality shoes that combine style, comfort, and durability. We carefully curate our collection to ensure that every pair meets our high standards of craftsmanship.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, height: 1.6, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),

            // Values Grid
            Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildValueCard(
                        context,
                        Icons.verified,
                        'Premium Quality',
                        'We source only the finest materials for our footwear.',
                      ),
                      _buildValueCard(
                        context,
                        Icons.local_shipping,
                        'Fast Shipping',
                        'Free shipping on all orders over \$100 worldwide.',
                      ),
                      _buildValueCard(
                        context,
                        Icons.support_agent,
                        '24/7 Support',
                        'Our customer service team is always here to help.',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 80),

            // Team Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    'Meet The Team',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildTeamMember(
                        'John Christopher A. Aguilan',
                        'Founder & CEO',
                        'assets/images/profile.jpg',
                      ),
                      _buildTeamMember(
                        'Joyce Ann Fernandez',
                        'Head of Design',
                        'assets/images/joyce.jpg',
                      ),
                      _buildTeamMember(
                        'King Humphrey Amandy',
                        'Product Manager',
                        'assets/images/king.jpg',
                      ),
                      _buildTeamMember(
                        'Frenz Dave Dacillo',
                        'Product Manager',
                        'assets/images/frenz.jpg',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),

            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildValueCard(BuildContext context, IconData icon, String title, String description) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: AppTheme.primaryColor),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role, String imageUrl) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            imageUrl,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          role,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
