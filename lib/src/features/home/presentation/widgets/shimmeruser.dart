import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonListuser extends StatelessWidget {
  const SkeletonListuser({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProductSkeleton();
  }
}

class _ProductSkeleton extends StatelessWidget {
  _ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _shimmerBox(width: 50, height: 50, radius: 50),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(width: double.infinity, height: 10, radius: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    required double radius,
  }) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(246, 246, 246, 246), // رمادي داكن أو أبيض
      highlightColor: const Color.fromARGB(
          255, 255, 255, 255), // رمادي فاتح أو قريب من الأبيض

      /* baseColor: const Color.fromARGB(255, 255, 254, 254), // أزرق فيسبوك غامق
      highlightColor: const Color.fromARGB(158, 244, 244, 244), // أزرق فاتح*/
      child: Container(
        decoration: BoxDecoration(
          // ✅ صح
          borderRadius: BorderRadius.circular(radius),
          color: Colors.white,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
