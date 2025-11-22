import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('About Arekatika', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/images/logo.png', width: 56, height: 56, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Arekatika Meat Udyog Ltd.', style: FontUtils.semiBold(size: 16, color: AppColors.brandGreen)),
                      const SizedBox(height: 4),
                      Text('Heritage. Dignity. Progress.\nFresh goat meat sourced responsibly and\ndelivered chilled — never frozen.',
                          style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          _infoTile('Freshness Guaranteed', 'Cold-chain delivery ensures tenderness & taste.', Icons.ac_unit_outlined),
          _infoTile('Hygienically Processed', 'Butcher-trained teams follow strict sanitation protocols.', Icons.health_and_safety_outlined),
          _infoTile('Trusted Sourcing', 'Partner farms selected for welfare and quality standards.', Icons.verified_user_outlined),

          const SizedBox(height: 12),
          _card(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FSSAI Certified', style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
                      const SizedBox(height: 2),
                      Text('License: 1234567890', style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Chilled Delivery', style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
                      const SizedBox(height: 2),
                      Text('Maintained at 0–4°C', style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Need Help?', style: FontUtils.semiBold(size: 14, color: AppColors.brandGreen)),
                const SizedBox(height: 4),
                Text('Customer Care: +91 98XXXXXXX\nsupport@arekatika.in', style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: Text('Contact Us', style: FontUtils.bold(size: 13, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.brandGreen,
                          side: const BorderSide(color: AppColors.brandGreen),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('View Processes', style: FontUtils.bold(size: 13, color: AppColors.brandGreen)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
          Center(
            child: Column(
              children: [
                Text('Proudly serving heritage in every cut.', style: FontUtils.semiBold(size: 12, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('You can always access more details in the Help section.',
                    style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: child,
    );
  }

  Widget _infoTile(String title, String sub, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 18, backgroundColor: AppColors.surface2, child: Icon(icon, color: AppColors.brandGreen, size: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(sub, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
