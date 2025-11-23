import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if we are on a large screen (web/desktop)
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=2070&auto=format&fit=crop',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey);
              },
            ),
          ),
          
          // Dark Overlay for better text visibility
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.6),
                    Colors.black.withValues(alpha: 0.9),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          // Content
          Positioned.fill(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: isLargeScreen ? MainAxisAlignment.center : MainAxisAlignment.end,
                      children: [
                        if (!isLargeScreen) const Spacer(),
                        
                        // Title
                        Text(
                          'UrbanKicks',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: isLargeScreen ? 80 : 56,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                            letterSpacing: -1.0,
                          ),
                        ),
                        
                        Text(
                          'Step Into\nThe Future',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: isLargeScreen ? 64 : 40,
                            fontWeight: FontWeight.w300,
                            height: 1.1,
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Subtitle
                        Text(
                          "Discover the latest trends in footwear fashion. Premium quality, unmatched comfort.",
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: isLargeScreen ? 20 : 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                        
                        const SizedBox(height: 48),
                        
                        // "Get Started" Button
                        SizedBox(
                          width: isLargeScreen ? 250 : double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Shop Now',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        if (isLargeScreen) const SizedBox(height: 0) else const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
