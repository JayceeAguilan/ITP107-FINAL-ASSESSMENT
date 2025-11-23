import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint;

    return Container(
      color: AppTheme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
            child: Column(
              children: [
                if (isLargeScreen)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildBrandColumn(context)),
                      Expanded(child: _buildLinksColumn(context, 'Shop', ['All Products', 'New Arrivals', 'Featured', 'Categories'])),
                      Expanded(child: _buildLinksColumn(context, 'Company', ['About Us', 'Contact', 'Careers', 'Press'])),
                      Expanded(child: _buildLinksColumn(context, 'Support', ['FAQs', 'Shipping', 'Returns', 'Privacy Policy'])),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildBrandColumn(context),
                      const SizedBox(height: 32),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildLinksColumn(context, 'Shop', ['All Products', 'New Arrivals', 'Featured'])),
                          Expanded(child: _buildLinksColumn(context, 'Company', ['About Us', 'Contact', 'Careers'])),
                        ],
                      ),
                    ],
                  ),
                
                const SizedBox(height: 48),
                const Divider(color: Colors.white24),
                const SizedBox(height: 24),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '© 2025 UrbanKicks. All rights reserved.',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
                    ),
                    Row(
                      children: [
                        _SocialIcon(icon: Icons.facebook),
                        _SocialIcon(icon: Icons.camera_alt), // Instagram
                        _SocialIcon(icon: Icons.alternate_email), // Twitter/X
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UrbanKicks',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Premium footwear for the modern lifestyle. Quality, comfort, and style in every step.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), height: 1.5),
        ),
      ],
    );
  }

  Widget _buildLinksColumn(BuildContext context, String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {},
            child: Text(
              link,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),
          ),
        )),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;

  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
