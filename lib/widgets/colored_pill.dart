import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class ColoredPill extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color bgColor;
  final Color? textColor;
  const ColoredPill({super.key, required this.text, this.icon, required this.bgColor, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor ?? AppColors.textTertiary),
            const SizedBox(width: 6),
          ],
          Text(text, style: FontUtils.regular(size: 11, color: textColor ?? AppColors.textTertiary)),
        ],
      ),
    );
  }
}
