import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/segmented_tabs.dart';
import 'package:arekatika/widgets/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int tab = 0; // 0=All, 1=Offers, 2=Updates

  @override
  Widget build(BuildContext context) {
    final itemsToday = _dataToday.where((e) => tab == 0 || e.type == tab).toList();
    final itemsEarlier = _dataEarlier.where((e) => tab == 0 || e.type == tab).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('Notification', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SegmentedTabs(
            labels: const ['All', 'Offers', 'Updates'],
            selectedIndex: tab,
            onChanged: (i) => setState(() => tab = i),
          ),
          Expanded(
            child: ListView(
              children: [
                if (itemsToday.isNotEmpty) _sectionHeader('Today'),
                ...itemsToday
                    .map((e) => NotificationItem(
                          leadingIcon: e.icon,
                          title: e.title,
                          subtitle: e.subtitle,
                          timeLabel: e.timeLabel,
                          onAction: () {},
                        ))
                    .toList(),
                if (itemsEarlier.isNotEmpty) _sectionHeader('Earlier'),
                ...itemsEarlier
                    .map((e) => NotificationItem(
                          leadingIcon: e.icon,
                          title: e.title,
                          subtitle: e.subtitle,
                          timeLabel: e.timeLabel,
                          onAction: () {},
                        ))
                    .toList(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _fakeBottomNav(),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Text(title, style: FontUtils.semiBold(size: 12, color: AppColors.textTertiary)),
    );
  }


  Widget _fakeBottomNav() {
    return Container(
      height: 58,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, -2))]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _NavItem(icon: Icons.home, label: 'Home', selected: true),
          _NavItem(icon: Icons.grid_view_rounded, label: 'Categories'),
          _NavItem(icon: Icons.shopping_bag_outlined, label: 'Cart'),
          _NavItem(icon: Icons.person_outline, label: 'Account'),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const _NavItem({required this.icon, required this.label, this.selected = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: selected ? AppColors.brandGreen : AppColors.textTertiary),
        const SizedBox(height: 2),
        Text(label, style: selected ? FontUtils.semiBold(size: 10, color: AppColors.brandGreen) : FontUtils.regular(size: 10, color: AppColors.textTertiary)),
      ],
    );
  }
}

class _Notif {
  final int type; // 1=Offers, 2=Updates
  final String title;
  final String subtitle;
  final String timeLabel;
  final IconData icon;
  const _Notif({required this.type, required this.title, required this.subtitle, required this.timeLabel, required this.icon});
}

final _dataToday = <_Notif>[
  const _Notif(type: 1, title: 'Weekend Offer', subtitle: 'Get ₹100 off on Family Feast Pack this weekend only!', timeLabel: 'Today • 09:15 AM', icon: Icons.card_giftcard),
  const _Notif(type: 1, title: 'Fresh Arrivals', subtitle: 'Quick Cooking Mutton Pack now available in store!', timeLabel: 'Today • 11:00 AM', icon: Icons.local_fire_department_outlined),
  const _Notif(type: 2, title: 'Arekatika Update', subtitle: 'New hygienic facility now operational for fresher cuts!', timeLabel: 'Today • 5:00 PM', icon: Icons.eco_outlined),
];

final _dataEarlier = <_Notif>[
  const _Notif(type: 2, title: 'Arekatika Update', subtitle: 'Marinate your mutton with yogurt for 30mins for extra tenderness!', timeLabel: '3 days ago', icon: Icons.lightbulb_outline),
];
