import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/screens/payment/payment.dart';

class SummaryScreen extends StatelessWidget {
  final String address;
  final String slot;
  const SummaryScreen({super.key, required this.address, required this.slot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('Payment', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _row('Total Due', '₹689', trailingIcon: Icons.check_circle, trailingColor: AppColors.brandGreen),
          const SizedBox(height: 12),
          _card(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/images/mutton.png', width: 56, height: 56, fit: BoxFit.cover),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Goat Curry Cut – Home Style(500g)', style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text(slot, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
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
                Text('All payment options', style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
                const SizedBox(height: 10),
                _payRow('UPI Payment', 'Pay instantly using PhonePe, GPay etc', true),
                const SizedBox(height: 8),
                _payRow('Credit/Debit/ATM Card', 'Visa, Mastercard, Amex, RuPay and more', true),
                const SizedBox(height: 8),
                _payRow('Net Banking', '18+ banks available', true),
                const SizedBox(height: 8),
                _payRow('Cash on Delivery', 'Pay securely in cash when order arrives.', true),
                const SizedBox(height: 8),
                _payRow('Mobile Wallets', 'AmazonPay, Mobikwik, PhonePe and more', true),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PaymentScreen(total: 689),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Text('Proceed to Pay ₹689', style: FontUtils.bold(size: 14, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {IconData? trailingIcon, Color? trailingColor}) {
    return Row(
      children: [
        Text(label, style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
        const Spacer(),
        if (trailingIcon != null) ...[
          Icon(trailingIcon, size: 16, color: trailingColor ?? AppColors.textPrimary),
          const SizedBox(width: 6),
        ],
        Text(value, style: FontUtils.bold(size: 14, color: AppColors.textPrimary)),
      ],
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

  Widget _payRow(String title, String sub, bool ok) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
              const SizedBox(height: 2),
              Text(sub, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
        Icon(Icons.check_circle, size: 16, color: AppColors.brandGreen),
      ],
    );
  }
}
