import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/quick_action_tile.dart';
import 'package:arekatika/widgets/stat_card.dart';
import 'package:arekatika/widgets/list_arrow_tile.dart';
import 'package:arekatika/screens/account/edit_profile.dart';
import 'package:arekatika/screens/account/reviews.dart';
import 'package:arekatika/screens/account/saved_addresses.dart';
import 'package:arekatika/screens/notifications/notifications.dart';
import 'package:arekatika/screens/account/about.dart';
import 'package:arekatika/widgets/simple_page.dart';
import 'package:arekatika/screens/auth/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Balaji Rajanwad';
  String _phone = '+91 96760 10330';
  String _email = 'valkontek@gmail.com';
  Uint8List? _avatarBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('My Profile', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  final result = await Navigator.of(context).push<Map<String, dynamic>>(
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  );
                  if (result != null) {
                    setState(() {
                      _name = (result['name'] as String?)?.trim().isNotEmpty == true ? result['name'] as String : _name;
                      _phone = (result['phone'] as String?)?.trim().isNotEmpty == true ? result['phone'] as String : _phone;
                      _email = (result['email'] as String?)?.trim().isNotEmpty == true ? result['email'] as String : _email;
                      _avatarBytes = result['avatarBytes'] as Uint8List? ?? _avatarBytes;
                    });
                  }
                },
                child: Text('Edit', style: FontUtils.semiBold(size: 14, color: AppColors.brandGreen)),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          _header(),
          const SizedBox(height: 16),
          Text('Quick Actions', style: FontUtils.semiBold(size: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          _quickActionsGrid(context),
          const SizedBox(height: 16),
          Text('Order Overview', style: FontUtils.semiBold(size: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          _orderOverview(),
          const SizedBox(height: 16),
          _groupCard(
            title: 'Exclusive for You',
            children: const [
              ListArrowTile(title: 'Wallet ballance'),
              ListArrowTile(title: 'Active coupons'),
              ListArrowTile(title: 'Refer & earn program'),
            ],
          ),
          const SizedBox(height: 12),
          _groupCard(
            title: 'Support',
            children: const [
              ListArrowTile(title: 'Help center'),
              ListArrowTile(title: 'Returns policy'),
              ListArrowTile(title: 'About us'),
              ListArrowTile(title: 'Terms & privacy'),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout_rounded, color: Colors.white),
                  const SizedBox(width: 8),
                  Text('Logout', style: FontUtils.bold(size: 14, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    // derive initials from name if no avatar
    final initials = _name.trim().isNotEmpty
        ? _name.trim().split(RegExp(r"\s+")).map((p) => p.isNotEmpty ? p[0] : '').take(2).join().toUpperCase()
        : 'BR';
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: AppColors.surface2,
              backgroundImage: _avatarBytes != null ? MemoryImage(_avatarBytes!) : null,
              child: _avatarBytes == null ? Text(initials, style: FontUtils.bold(size: 16, color: AppColors.textPrimary)) : null,
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: AppColors.warningBg, shape: BoxShape.circle),
                child: const Icon(Icons.camera_alt_rounded, color: AppColors.warning, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(_name, style: FontUtils.bold(size: 16, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text(_phone, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
        Text(_email, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _quickActionsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        QuickActionTile(
          icon: Icons.receipt_long_rounded,
          label: 'Orders',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const SimplePage(title: 'Orders', message: 'Your past and current orders will appear here.'),
            ),
          ),
        ),
        QuickActionTile(
          icon: Icons.location_pin,
          label: 'Address',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SavedAddressesScreen()),
          ),
        ),
        QuickActionTile(
          icon: Icons.reviews_rounded,
          label: 'Reviews',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ReviewsScreen()),
          ),
        ),
        QuickActionTile(
          icon: Icons.credit_card_rounded,
          label: 'Payments',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const SimplePage(title: 'Payments', message: 'Manage and view your payment methods here.'),
            ),
          ),
        ),
        QuickActionTile(
          icon: Icons.emoji_events_rounded,
          label: 'Rewards',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const SimplePage(title: 'Rewards', message: 'Track your rewards and offers here.'),
            ),
          ),
        ),
        QuickActionTile(
          icon: Icons.notifications_active_outlined,
          label: 'Notification',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
          ),
        ),
      ],
    );
  }

  Widget _orderOverview() {
    return Row(
      children: const [
        Expanded(child: StatCard(value: '1', label: 'Preparing')),
        SizedBox(width: 10),
        Expanded(child: StatCard(value: '2', label: 'Delivered')),
        SizedBox(width: 10),
        Expanded(child: StatCard(value: '3', label: 'Rated')),
      ],
    );
  }

  Widget _groupCard({required String title, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Text(title, style: FontUtils.semiBold(size: 14, color: AppColors.textSecondary)),
            ),
            const Divider(height: 0, color: AppColors.stroke),
            ...children,
        ],
      ),
    );
  }
}
