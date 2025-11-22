import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/empty_state.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('Reviews', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: EmptyState(
            imageAsset: 'assets/images/Rating of product or service.png',
            title: 'No reviews yet',
            lines: const [
              'You haven\'t reviewed any items yet. Once your order is',
              'delivered, you can quickly rate the product and delivery.',
              '',
              'Reviews help others choose the best cuts  and help',
              'us serve you better.',
            ],
            buttonText: 'Explore Mutton Cuts',
            onButton: () {
              Navigator.of(context).pop();
            },
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
          ),
        ),
      ),
      backgroundColor: AppColors.bg,
    );
  }
}
