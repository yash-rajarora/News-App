import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:newsapp/utils/constants/colors.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key, required this.width, required this.height, this.radius = 15, this.color});

  final double width,height,radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:Colors.grey[300]!,
      highlightColor:Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (TColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}