import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  const StatCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: FontUtils.bold(size: 18, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(label, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
