import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonBase extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonBase({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class SkeletonProductCard extends StatelessWidget {
  const SkeletonProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                const SkeletonBase(width: 100, height: 14),
                const SizedBox(height: 8),
                // Price placeholder
                const SkeletonBase(width: 60, height: 14),
                const SizedBox(height: 8),
                // Rating placeholder
                const Row(
                  children: [
                    SkeletonBase(width: 14, height: 14),
                    SizedBox(width: 4),
                    SkeletonBase(width: 20, height: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
