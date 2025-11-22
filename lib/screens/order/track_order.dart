import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/screens/dashboard/dashboard.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('Track Order', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("We'll notify you once it's out for delivery",
                style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            _step('Order Placed', 'We\'ve received your order.', true),
            _step('Order Confirmed', 'Our team is preparing your order.', true),
            _step('Out for Delivery', 'Your order will arrive between 8–10 AM.', false),
            _step('Delivered', 'Pending delivery confirmation', false),
            const Spacer(),
            _details(),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const Dashboard()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Back to Home', style: FontUtils.bold(size: 14, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _step(String title, String sub, bool done) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(done ? Icons.check_circle : Icons.radio_button_unchecked,
            color: done ? AppColors.brandGreen : AppColors.textTertiary, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
              const SizedBox(height: 2),
              Text(sub, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _details() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Details', style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          _row('Order ID', '#VXC2384'),
          _row('Delivery Slot', 'Tomorrow, 8:00 – 10:00 AM'),
          _row('Payment', 'Paid via PhonePe'),
        ],
      ),
    );
  }

  Widget _row(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(k, style: FontUtils.regular(size: 12, color: AppColors.textSecondary))),
          Text(v, style: FontUtils.semiBold(size: 12, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
