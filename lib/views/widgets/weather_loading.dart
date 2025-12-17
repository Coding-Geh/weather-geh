import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          _shimmerBox(width: 150, height: 32),
          const SizedBox(height: 8),
          _shimmerBox(width: 60, height: 16),
          const SizedBox(height: 30),
          _shimmerBox(width: 120, height: 120, radius: 60),
          const SizedBox(height: 20),
          _shimmerBox(width: 100, height: 60),
          const SizedBox(height: 12),
          _shimmerBox(width: 120, height: 16),
          const SizedBox(height: 40),
          _shimmerBox(width: double.infinity, height: 200, radius: 20),
          const SizedBox(height: 20),
          _shimmerBox(width: double.infinity, height: 150, radius: 20),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.4),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
