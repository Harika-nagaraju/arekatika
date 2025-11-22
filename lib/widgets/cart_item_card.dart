import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/qty_stepper.dart';
import 'package:arekatika/widgets/colored_pill.dart';

class CartItemCard extends StatelessWidget {
  final String title;
  final String subtitle; // e.g., Special price
  final String price;
  final String mrp;
  final String discountText;
  final String image;
  final int qty;
  final VoidCallback onRemove;
  final VoidCallback onInc;
  final VoidCallback onDec;
  final bool showInfoPills;
  final bool showRemove;
  const CartItemCard({super.key, required this.title, required this.subtitle, required this.price, required this.mrp, required this.discountText, required this.image, required this.qty, required this.onRemove, required this.onInc, required this.onDec, this.showInfoPills = true, this.showRemove = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 86, height: 86, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(subtitle, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(price, style: FontUtils.bold(size: 14, color: AppColors.brandGreen)),
                    const SizedBox(width: 6),
                    Text(mrp, style: FontUtils.regular(size: 12, color: AppColors.textTertiary).copyWith(decoration: TextDecoration.lineThrough)),
                    const SizedBox(width: 6),
                    Text(discountText, style: FontUtils.semiBold(size: 12, color: AppColors.brandGreen)),
                  ],
                ),
                const SizedBox(height: 8),
                if (showInfoPills) ...[
                  Row(
                    children: const [
                      ColoredPill(text: 'Delivery in 60 mins', icon: Icons.timer_outlined, bgColor: AppColors.infoBg),
                      SizedBox(width: 8),
                      ColoredPill(text: 'You Have Saved ₹50', bgColor: AppColors.successBg, textColor: AppColors.brandGreen),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: AppColors.brandGreen, borderRadius: BorderRadius.circular(8)),
                      child: QtyStepper(
                        value: qty == 0 ? 1 : qty,
                        onIncrement: onInc,
                        onDecrement: onDec,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (showRemove)
                      GestureDetector(onTap: onRemove, child: Text('Remove', style: FontUtils.semiBold(size: 12, color: AppColors.error))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
