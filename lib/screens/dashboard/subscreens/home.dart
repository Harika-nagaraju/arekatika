import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/screens/home/mutton_category.dart';
import 'package:arekatika/screens/product/product_detail.dart';
import 'package:arekatika/screens/notifications/notifications.dart';
import 'package:arekatika/controllers/location_controller.dart';
import 'package:arekatika/controllers/search_controller.dart';
import 'package:arekatika/controllers/cart_controller.dart';
import 'package:arekatika/models/product.dart';
import 'package:arekatika/routes/app_routes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _openLocationSelector() {
    Get.toNamed(Routes.locationAccess);
  }

  void _handleDeliverToTap(LocationController locCtrl) async {
    if (!locCtrl.isLocationEnabled.value &&
        locCtrl.selectedAddress.value.isEmpty) {
      Get.defaultDialog(
        title: 'Enable Location',
        middleText: 'Turn on your location to get accurate delivery options.',
        confirm: TextButton(
          onPressed: () async {
            Get.back();
            await locCtrl.enableLocation();
          },
          child: const Text('Enable'),
        ),
        cancel: TextButton(
          onPressed: () => Get.back(),
          child: const Text('Later'),
        ),
      );
    } else {
      _openLocationSelector();
    }
  }

  void _openSearchSheet(HomeSearchController searchCtrl) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: searchCtrl.updateQuery,
              decoration: const InputDecoration(
                hintText: 'Search for dishes or categories',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              final items = searchCtrl.filteredProducts;
              if (items.isEmpty) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'No results found',
                    style: FontUtils.regular(size: 13, color: AppColors.textSecondary),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final p = items[i];
                  return ListTile(
                    title: Text(p.name),
                    subtitle: Text(p.subtitle),
                    trailing: Text('₹${p.price}'),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _onReferTap() {
    Get.toNamed(Routes.refer);
  }

  void _shareReferCode() {
    Share.share(
      'Hey! Try Arekatika for premium goat & mutton cuts. Use my code BALAJI10 for a discount!',
      subject: 'Refer & Earn – Arekatika',
    );
  }

  @override
  Widget build(BuildContext context) {
    final locCtrl = Get.find<LocationController>();
    final searchCtrl = Get.find<HomeSearchController>();
    final cartCtrl = Get.find<CartController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: const BoxDecoration(
              color: Color(0xFF1B7B3A),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final addr = locCtrl.selectedAddress.value;
                  final hasLocation = addr.isNotEmpty;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                        child: InkWell(
                          onTap: () => _handleDeliverToTap(locCtrl),
                          child: Text(
                            hasLocation
                                ? 'Deliver To •\n$addr'
                                : 'Deliver To •\nEnable location to see delivery address',
                            style: FontUtils.regular(size: 12, color: Colors.white70),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                          );
                        },
                        child: const Icon(Icons.notifications_none, color: Colors.white, size: 20),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 10),
                Text('Welcome Balaji', style: FontUtils.bold(size: 18, color: Colors.white)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7E9), // light cream like design
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    readOnly: true,
                    onTap: () => _openSearchSheet(searchCtrl),
                    style: FontUtils.regular(size: 13, color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Type product name to search...',
                      hintStyle: FontUtils.regular(size: 13, color: AppColors.textTertiary),
                      prefixIcon: const Icon(Icons.search, color: AppColors.textTertiary),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Special Offers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Special Offers',
              style: FontUtils.bold(size: 16, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/offercard.png',
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Explore Mutton Cuts (now as 3-column grid)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Explore Mutton Cuts',
              style: FontUtils.bold(size: 16, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 24,
              childAspectRatio: 0.85,
              children: const [
                _HomeCategoryCircle(
                  image: 'assets/images/currucut.png',
                  label: 'Curry-\nReady Cuts',
                ),
                _HomeCategoryCircle(
                  image: 'assets/images/bonlessminced.png',
                  label: 'Boneless &\nMinced',
                ),
                _HomeCategoryCircle(
                  image: 'assets/images/premiumselection.png',
                  label: 'Premium\nSelection',
                ),
                _HomeCategoryCircle(
                  image: 'assets/images/boneless.png',
                  label: 'Organs &\nMore',
                ),
                _HomeCategoryCircle(
                  image: 'assets/images/specality.png',
                  label: 'Speciality\nCuts',
                ),
                _HomeCategoryCircle(
                  image: 'assets/images/valuecombos.png',
                  label: 'Value\nCombos',
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Recommended Dishes header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Recommended Dishes',
              style: FontUtils.bold(size: 16, color: AppColors.brandOrange),
            ),
          ),
          const SizedBox(height: 8),

          Obx(() {
            final list = searchCtrl.filteredProducts;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: list.map((p) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ProductCard(
                      title: p.name,
                      subtitle: p.subtitle,
                      price: '₹${p.price}',
                      image: p.image ?? 'assets/images/mutton.png',
                      onAdd: () {
                        cartCtrl.addProduct(p);
                        Get.snackbar('Added to cart', p.name, snackPosition: SnackPosition.BOTTOM);
                      },
                      onOpen: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                              args: ProductDetailArgs(
                                title: p.name,
                                subtitle: p.subtitle,
                                weightMeta: p.subtitle,
                                price: '₹${p.price}',
                                mrp: '₹${(p.price * 1.1).round()}',
                                discount: 10,
                                image: p.image,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _HomeCategoryCircle extends StatelessWidget {
  final String image;
  final String label;
  const _HomeCategoryCircle({required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset(
            image,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 72,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: FontUtils.regular(size: 11, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String image;
  final VoidCallback onAdd;
  final VoidCallback? onOpen;

  const _ProductCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
    required this.onAdd,
    this.onOpen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpen,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // image row so it stays proportionate on various device widths
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: FontUtils.regular(size: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              price,
                              style: FontUtils.bold(size: 14, color: AppColors.brandGreen),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Incl. all taxes',
                              style: FontUtils.regular(size: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Add button (compact)
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: onAdd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add, size: 16),
                          const SizedBox(width: 6),
                          Text('Add', style: FontUtils.semiBold(size: 13, color: Colors.white)),
                        ],
                      ),
                    ),
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
