import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class SimplePage extends StatelessWidget {
  final String title;
  final String message;
  const SimplePage({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text(title, style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: FontUtils.regular(size: 14, color: AppColors.textSecondary),
          ),
        ),
      ),
      backgroundColor: AppColors.bg,
    );
  }
}
