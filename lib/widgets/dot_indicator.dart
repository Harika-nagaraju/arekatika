// lib/widgets/dots_indicator.dart
import 'package:flutter/material.dart';
import '../utils/appcolors.dart';

class DotsIndicator extends StatelessWidget {
  final int count;
  final int activeIndex;
  final double size; // dot diameter
  final double spacing; // gap between dots
  final Color activeColor;
  final Color inactiveColor;

  const DotsIndicator({
    Key? key,
    required this.count,
    required this.activeIndex,
    this.size = 8,
    this.spacing = 10,
    this.activeColor = AppColors.brandGreen,
    this.inactiveColor = AppColors.gray2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final bool isActive = i == activeIndex;
        return Container(
          width: size,
          height: size,
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : spacing),
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
