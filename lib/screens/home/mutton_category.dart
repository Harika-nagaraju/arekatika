import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/screens/product/product_detail.dart';
import 'package:arekatika/controllers/cart_controller.dart';
import 'package:arekatika/models/product.dart';

class MuttonCategoryScreen extends StatefulWidget {
  const MuttonCategoryScreen({super.key});
  @override
  State<MuttonCategoryScreen> createState() => _MuttonCategoryScreenState();
}

class _MuttonCategoryScreenState extends State<MuttonCategoryScreen> {
  int _selected = 0; // 0: All, 1: Curry Cut, 2: Boneless & Minced, 3: Premium Selection
  final CartController cartCtrl = Get.find<CartController>();

  List<Map<String, String>> _productsFor(int tab) {
    // Minimal demo data switching based on tab; uses provided assets
    switch (tab) {
      case 1: // Curry Cut
        return [
          {
            'title': 'Goat Curry Cut – Home Style',
            'subtitle': 'Tender goat, rich with bone-in flavor',
            'weight': '500 g | 20–25 pieces | Serves 2–3',
            'price': '₹589',
            'mrp': '₹649',
            'img': 'assets/images/mutton.png',
          },
        ];
      case 2: // Boneless & Minced
        return [
          {
            'title': 'Boneless Mutton–Lean',
            'subtitle': 'Boneless mutton cubes. perfectly versatile.',
            'weight': '500 g | 15–18 pieces | Serves 2–3',
            'price': '₹619',
            'mrp': '₹689',
            'img': 'assets/images/boneless.png',
          },
        ];
      case 3: // Premium Selection
        return [
          {
            'title': 'Premium Selection',
            'subtitle': 'Chef curated premium cuts.',
            'weight': '500 g | Serves 2–3',
            'price': '₹749',
            'mrp': '₹829',
            'img': 'assets/images/premium.png',
          },
        ];
      default: // All
        return [
          {
            'title': 'Goat Curry Cut – Home Style',
            'subtitle': 'Tender goat, rich with bone-in flavor',
            'weight': '500 g | 20–25 pieces | Serves 2–3',
            'price': '₹589',
            'mrp': '₹649',
            'img': 'assets/images/mutton.png',
          },
          {
            'title': 'Boneless Mutton–Lean',
            'subtitle': 'Boneless mutton cubes. perfectly versatile.',
            'weight': '500 g | 15–18 pieces | Serves 2–3',
            'price': '₹619',
            'mrp': '₹689',
            'img': 'assets/images/boneless.png',
          },
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = const [
      {'img': 'assets/images/currucut.png', 'label': 'All'},
      {'img': 'assets/images/currucut.png', 'label': 'Curry Cut'},
      {'img': 'assets/images/bonlessminced.png', 'label': 'Boneless &\nMinced'},
      {'img': 'assets/images/premium.png', 'label': 'Premium\nSelection'},
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F7A3D),
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mutton', style: FontUtils.bold(size: 18, color: Colors.white)),
            const SizedBox(height: 2),
            Text('All Categories', style: FontUtils.regular(size: 12, color: Colors.white70)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Green band with horizontal categories
            Container(
              color: const Color(0xFF1F7A3D),
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 14),
              child: SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < categories.length; i++)
                      _CategoryChip(
                        selected: i == _selected,
                        image: categories[i]['img']!,
                        label: categories[i]['label']!,
                        onTap: () => setState(() => _selected = i),
                      ),
                  ],
                ),
              ),
            ),
            Container(height: 12, color: const Color(0xFFE7F2FF)),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  for (int i = 0; i < _productsFor(_selected).length; i++) ...[
                    Builder(builder: (context) {
                      final data = _productsFor(_selected)[i];
                      final product = Product(
                        id: data['title']!,
                        name: data['title']!,
                        subtitle: data['subtitle']!,
                        price: int.tryParse(data['price']!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
                        image: data['img']!,
                      );
                      return _ProductCard(
                        title: data['title']!,
                        subtitle: data['subtitle']!,
                        weightMeta: data['weight']!,
                        price: data['price']!,
                        mrp: data['mrp']!,
                        discountText: '10% off',
                        image: data['img']!,
                        onAdd: () {
                          cartCtrl.addProduct(product);
                          Get.snackbar(
                            'Added to cart',
                            product.name,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      );
                    }),
                    if (i != _productsFor(_selected).length - 1) const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String weightMeta;
  final String price;
  final String mrp;
  final String discountText;
  final String image;
  final VoidCallback onAdd;
  const _ProductCard({
    required this.title,
    required this.subtitle,
    required this.weightMeta,
    required this.price,
    required this.mrp,
    required this.discountText,
    required this.image,
    required this.onAdd,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              args: ProductDetailArgs(
                title: title,
                subtitle: subtitle,
                weightMeta: weightMeta,
                price: price,
                mrp: mrp,
                discount: 10,
                image: image,
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.stroke, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(image, height: 160, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                  const SizedBox(height: 10),
                  Text(weightMeta, style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.bolt, size: 16, color: Colors.orange),
                      const SizedBox(width: 6),
                      Text('Delivery in 60 mins', style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(price, style: FontUtils.bold(size: 18, color: AppColors.brandGreen)),
                      const SizedBox(width: 8),
                      Text(mrp, style: FontUtils.regular(size: 13, color: AppColors.textSecondary).copyWith(decoration: TextDecoration.lineThrough)),
                      const SizedBox(width: 6),
                      Text(discountText, style: FontUtils.semiBold(size: 12, color: AppColors.brandGreen)),
                      const Spacer(),
                      _AddButton(onPressed: onAdd),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('Special Price for you', style: FontUtils.semiBold(size: 12, color: AppColors.brandGreen)),
                  const SizedBox(height: 4),
                  Text(
                    'High protein · Rich in iron',
                    style: FontUtils.regular(size: 11, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _AddButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brandGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: FontUtils.bold(size: 12, color: Colors.white),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(
        'ADD',
        style: FontUtils.bold(size: 12, color: Colors.white),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String image;
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  const _CategoryChip({required this.image, required this.label, this.selected = false, this.onTap});
  @override
  Widget build(BuildContext context) {
    final bg = selected ? Colors.white : Colors.white.withOpacity(0.12);
    final textColor = selected ? AppColors.textPrimary : Colors.white;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
      width: 84,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(image, width: 44, height: 44, fit: BoxFit.cover),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: FontUtils.regular(size: 12, color: textColor),
          ),
          const SizedBox(height: 4),
          if (selected)
            Container(height: 2, width: 24, decoration: BoxDecoration(color: const Color(0xFFFF8A3D), borderRadius: BorderRadius.circular(2))),
        ],
      ),
      ),
    );
  }
}
