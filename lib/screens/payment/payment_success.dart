import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/screens/order/track_order.dart';
import 'package:arekatika/screens/dashboard/dashboard.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface2,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 6))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, size: 72, color: AppColors.brandGreen),
                const SizedBox(height: 10),
                Text('Great!', style: FontUtils.bold(size: 18, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text('Payment Success', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text('Your payment was successfully completed through\nPhonePe. ₹689 received securely.',
                    textAlign: TextAlign.center,
                    style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Order Details', style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
                ),
                const SizedBox(height: 8),
                _detailRow('Order ID', '#VXC2384'),
                _detailRow('Delivery Slot', 'Tomorrow, 8:00 – 10:00 AM'),
                _detailRow('Payment', 'Paid via PhonePe'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const TrackOrderScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.brandGreen,
                      side: const BorderSide(color: AppColors.brandGreen),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Track Order', style: FontUtils.bold(size: 14, color: AppColors.brandGreen)),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const Dashboard()),
                        (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.stroke),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Continue Ordering', style: FontUtils.bold(size: 14, color: AppColors.textPrimary)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String k, String v) {
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
