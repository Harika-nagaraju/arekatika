import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class NotificationItem extends StatelessWidget {
  final IconData leadingIcon;
  final Color leadingBg;
  final String title;
  final String subtitle;
  final String timeLabel;
  final VoidCallback onAction;
  const NotificationItem({super.key, required this.leadingIcon, this.leadingBg = AppColors.surface2, required this.title, required this.subtitle, required this.timeLabel, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Row(
            children: [
              CircleAvatar(radius: 18, backgroundColor: leadingBg, child: Icon(leadingIcon, size: 18, color: AppColors.brandGreen)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Text(timeLabel, style: FontUtils.regular(size: 11, color: AppColors.textTertiary)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: onAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Order', style: FontUtils.bold(size: 12, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
