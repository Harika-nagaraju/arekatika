import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class EmptyState extends StatelessWidget {
  final String imageAsset;
  final String title;
  final List<String> lines;
  final String? buttonText;
  final VoidCallback? onButton;
  final EdgeInsetsGeometry padding;
  const EmptyState({super.key, required this.imageAsset, required this.title, required this.lines, this.buttonText, this.onButton, this.padding = const EdgeInsets.fromLTRB(24, 24, 24, 24)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imageAsset, width: 160, fit: BoxFit.contain),
          const SizedBox(height: 16),
          Text(title, style: FontUtils.bold(size: 18, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          ...lines.map((l) => Text(l, textAlign: TextAlign.center, style: FontUtils.regular(size: 12, color: AppColors.textSecondary))),
          if (buttonText != null) ...[
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: onButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(buttonText!, style: FontUtils.bold(size: 14, color: Colors.white)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
