import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arekatika/controllers/bottom_nav_controller.dart';
import 'package:arekatika/controllers/location_controller.dart';
import 'package:arekatika/controllers/search_controller.dart';
import 'package:arekatika/controllers/cart_controller.dart';
import 'package:arekatika/screens/dashboard/subscreens/home.dart';
import 'package:arekatika/screens/home/mutton_category.dart';
import 'package:arekatika/screens/cart/cart.dart';
import 'package:arekatika/screens/account/profile.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/screens/cart/select_location_sheet.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final BottomNavController navCtrl = Get.put(BottomNavController());
  bool _popupsShown = false;

  @override
  void initState() {
    super.initState();
    // Register global controllers used across tabs
    Get.put<LocationController>(LocationController());
    Get.put<HomeSearchController>(HomeSearchController());
    Get.put<CartController>(CartController());
  }

  late final List<Widget> pages = [
    const Home(),
    const MuttonCategoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Show popups only once when dashboard first builds
    if (!_popupsShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _popupsShown = true;
        _showTurnOnLocationDialog();
      });
    }
    return SafeArea(
      child: Obx(
        () => Scaffold(
          backgroundColor: AppColors.bg,
          body: pages[navCtrl.selectedIndex.value],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: FontUtils.semiBold(size: 10),
              unselectedLabelStyle: FontUtils.regular(size: 10),
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.black54,
              currentIndex: navCtrl.selectedIndex.value,
              onTap: navCtrl.changeTabIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_rounded),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  label: 'Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showTurnOnLocationDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Turn On Location', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text(
                "We couldn't detect your area because GPS is turned off. Please enable location services to continue.",
                textAlign: TextAlign.center,
                style: FontUtils.regular(size: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showEnableLocationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: Text('Turn On GPS', style: FontUtils.bold(size: 14, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showEnableLocationDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Optional illustration space (kept placeholder icon to avoid missing asset)
              const Icon(Icons.my_location, size: 64, color: AppColors.brandGreen),
              const SizedBox(height: 12),
              Text('Enable Location Access', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text(
                'We use your location to find the nearest delivery area and ensure your fresh meat reaches you on time.',
                textAlign: TextAlign.center,
                style: FontUtils.regular(size: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _showAllowLocationAccessDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: Text('Use Current Location', style: FontUtils.bold(size: 14, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await showModalBottomSheet<String>(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (_) => SelectDeliveryLocationSheet(onAddNew: () {}),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.stroke),
                    foregroundColor: AppColors.textPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Search Your Location', style: FontUtils.bold(size: 14, color: AppColors.textPrimary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAllowLocationAccessDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/location.png',
                height: 140,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Text(
                'Allow Arekatika to access this devices location?',
                textAlign: TextAlign.center,
                style: FontUtils.semiBold(
                  size: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // TODO: put real permission logic here if you integrate GPS later
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Allow Location Access',
                    style: FontUtils.bold(size: 14, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Not now',
                  style: FontUtils.regular(
                    size: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
