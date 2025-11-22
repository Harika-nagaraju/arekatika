import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/screens/payment/payment_success.dart';

class PaymentScreen extends StatelessWidget {
  final int total;
  const PaymentScreen({super.key, required this.total});

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
          _dueRow('Total Due', '₹$total', true),
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
                      Text('Sun, 9 Nov (8AM – 10AM)', style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
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
                _optionTile('UPI Payment', 'Pay instantly using PhonePe, GPay etc', true),
                _optionTile('Credit/Debit/ATM Card', 'Visa, Mastercard, Amex, RuPay and more', true),
                _optionTile('Net Banking', '18+ banks available', true),
                _optionTile('Cash on Delivery', 'Pay securely in cash when order arrives.', true),
                _optionTile('Mobile Wallets', 'AmazonPay, Mobikwik, PhonePe and more', true),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Bottom sheet: select UPI app
              final ok = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => _SelectPaymentMethod(total: total),
              );
              if (ok == true && context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const PaymentSuccessScreen()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Text('Proceed to Pay ₹$total', style: FontUtils.bold(size: 14, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _dueRow(String label, String value, bool ok) {
    return Row(
      children: [
        Text(label, style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
        const Spacer(),
        if (ok) const Icon(Icons.check_circle, size: 16, color: AppColors.brandGreen),
        if (ok) const SizedBox(width: 6),
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

  Widget _optionTile(String title, String sub, bool ok) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
          subtitle: Text(sub, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
          trailing: const Icon(Icons.check_circle, size: 16, color: AppColors.brandGreen),
        ),
        const Divider(height: 0),
      ],
    );
  }
}

class _SelectPaymentMethod extends StatefulWidget {
  final int total;
  const _SelectPaymentMethod({required this.total});

  @override
  State<_SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<_SelectPaymentMethod> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.payments, color: AppColors.brandGreen),
                const SizedBox(width: 8),
                Text('Select Payment Method', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(false),
                )
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _appTile('PhonePe'),
                _appTile('GPay'),
                _appTile('Paytm'),
                _appTile('AmazonPay'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: selected == null ? null : () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Proceed to Pay ₹${widget.total}', style: FontUtils.bold(size: 14, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appTile(String name) {
    final sel = selected == name;
    return GestureDetector(
      onTap: () => setState(() => selected = name),
      child: Container(
        width: 92,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: sel ? AppColors.brandGreen : AppColors.stroke),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        alignment: Alignment.center,
        child: Text(name, style: sel ? FontUtils.semiBold(size: 12, color: AppColors.brandGreen) : FontUtils.regular(size: 12, color: AppColors.textPrimary)),
      ),
    );
  }
}
