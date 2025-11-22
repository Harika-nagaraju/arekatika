import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/tag_chip.dart';
import 'package:arekatika/widgets/qty_stepper.dart';
import 'package:arekatika/screens/cart/cart.dart';

class ProductDetailArgs {
  final String title;
  final String subtitle;
  final String weightMeta;
  final String price; // e.g., ₹589
  final String mrp; // e.g., ₹649
  final int discount; // e.g., 10
  final String image;
  const ProductDetailArgs({
    required this.title,
    required this.subtitle,
    required this.weightMeta,
    required this.price,
    required this.mrp,
    required this.discount,
    required this.image,
  });
}

class ProductDetailScreen extends StatefulWidget {
  final ProductDetailArgs args;
  const ProductDetailScreen({super.key, required this.args});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int qty = 0;

  @override
  Widget build(BuildContext context) {
    final a = widget.args;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('Current Order', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: Hook up to search flow when available
            },
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Image header
          ClipRRect(
            child: Image.asset(a.image, fit: BoxFit.cover, height: 228, width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TagChip(text: 'Freshly Cut'),
                    const SizedBox(width: 8),
                    TagChip(text: 'Antibiotic-Free'),
                    const SizedBox(width: 8),
                    TagChip(text: 'Delivery in 60 mins', icon: Icons.timer_outlined),
                  ],
                ),
                const SizedBox(height: 10),
                Text(a.title, style: FontUtils.semiBold(size: 18, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(a.subtitle, style: FontUtils.regular(size: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 12),
                _WeightPill(text: a.weightMeta),
                const SizedBox(height: 16),
                Text('Description:', style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                Text(
                  'Finest goat tender goat pieces, hygienically cleaned and expertly packed. Ideal for home-style curries, gravies, or biryanis. Every cut is trimmed for perfect texture and flavor.',
                  style: FontUtils.regular(size: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 12),
                Text('Storage Instructions:', style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                Text('Keep refrigerated at 0–4°C. Use within 24 hours of delivery.',
                    style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 16),
                // Pricing details above; action controls moved to fixed bottom bar
                const SizedBox(height: 16),
                Text('Energy: 140 kcal | Protein: 20g | Fat: 6g',
                    style: FontUtils.regular(size: 12, color: AppColors.textTertiary)),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        decoration: BoxDecoration(
          color: AppColors.bg,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: qty == 0
            ? Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _PriceRow(price: a.price, mrp: a.mrp, discount: a.discount),
                        const SizedBox(height: 4),
                        Text(
                          'Inclusive of all taxes',
                          style: FontUtils.regular(
                            size: 11,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () => setState(() => qty = 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandGreen,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                      ),
                      child: Text(
                        'Add to cart',
                        style: FontUtils.bold(
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.brandGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.brandGreenPressed,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '$qty item${qty > 1 ? 's' : ''}',
                                  style: FontUtils.semiBold(
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  a.price,
                                  style: FontUtils.semiBold(
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CartScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'View cart',
                              style: FontUtils.bold(
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  QtyStepper(
                    value: qty,
                    onIncrement: () => setState(() => qty += 1),
                    onDecrement: () => setState(
                      () => qty = qty > 1 ? qty - 1 : 1,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _WeightPill extends StatelessWidget {
  final String text;
  const _WeightPill({required this.text});
  @override
  Widget build(BuildContext context) {
    // Expecting format like: "500 g | 20–25 pieces | Serves 2–3"
    final parts = text.split('|').map((e) => e.trim()).toList();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < parts.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(parts[i], style: FontUtils.semiBold(size: 12, color: AppColors.textPrimary)),
            ),
            if (i != parts.length - 1)
              Container(width: 1, height: 20, color: AppColors.stroke),
          ],
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String price;
  final String mrp;
  final int discount;
  const _PriceRow({required this.price, required this.mrp, required this.discount});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(price, style: FontUtils.bold(size: 16, color: AppColors.brandGreen)),
        const SizedBox(width: 6),
        Text(mrp, style: FontUtils.regular(size: 12, color: AppColors.textTertiary).copyWith(decoration: TextDecoration.lineThrough)),
        const SizedBox(width: 6),
        Text('${discount}% off', style: FontUtils.semiBold(size: 12, color: AppColors.brandGreen)),
      ],
    );
  }
}
