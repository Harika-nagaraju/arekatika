import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class ProductSmallCard extends StatelessWidget {
  final String title;
  final String price;
  final String mrp;
  final String discountText;
  final String image;
  final VoidCallback onAdd;
  const ProductSmallCard({super.key, required this.title, required this.price, required this.mrp, required this.discountText, required this.image, required this.onAdd});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(image, height: 90, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: FontUtils.semiBold(size: 12, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(price, style: FontUtils.bold(size: 13, color: AppColors.brandGreen)),
                    const SizedBox(width: 6),
                    Text(mrp, style: FontUtils.regular(size: 11, color: AppColors.textTertiary).copyWith(decoration: TextDecoration.lineThrough)),
                    const SizedBox(width: 6),
                    Text(discountText, style: FontUtils.semiBold(size: 11, color: AppColors.brandGreen)),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: onAdd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text('Add +'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
