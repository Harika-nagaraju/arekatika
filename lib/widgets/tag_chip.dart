import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class TagChip extends StatelessWidget {
  final String text;
  final IconData? icon;
  const TagChip({super.key, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: AppColors.textTertiary),
            const SizedBox(width: 6),
          ],
          Text(text, style: FontUtils.regular(size: 11, color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}
