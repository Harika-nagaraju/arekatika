import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback? onTap;
  const QuickActionTile({super.key, required this.icon, required this.label, this.iconBg = AppColors.surface2, this.iconColor = AppColors.textPrimary, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 16, backgroundColor: iconBg, child: Icon(icon, size: 16, color: iconColor)),
            const SizedBox(height: 10),
            Text(label, style: FontUtils.semiBold(size: 12, color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}
