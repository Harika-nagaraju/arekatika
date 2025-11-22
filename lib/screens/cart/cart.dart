import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/cart_item_card.dart';
import 'package:arekatika/controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('Cart',
            style:
                FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
           body: Obx(() {
        if (cartCtrl.items.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }

        final entries = cartCtrl.items.entries.toList();

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          itemCount: entries.length + 1,
          itemBuilder: (_, index) {
            if (index == entries.length) {
              return _PriceDetails(total: cartCtrl.totalPrice);
            }

            final entry = entries[index];
            final p = entry.key;
            final qty = entry.value;

            return Dismissible(
              key: ValueKey(p.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => cartCtrl.removeProduct(p),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.redAccent,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CartItemCard(
                  title: p.name,
                  subtitle: p.subtitle,
                  price: '₹${p.price}',
                  mrp: '₹${(p.price * 1.1).round()}',
                  discountText: '10% off',
                  image: p.image,
                  qty: qty,
                  onRemove: () => cartCtrl.removeProduct(p),
                  onInc: () => cartCtrl.updateQuantity(p, qty + 1),
                  onDec: () => cartCtrl.updateQuantity(p, qty - 1),
                  showInfoPills: false,
                  showRemove: true,
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        final total = cartCtrl.totalPrice;
        return _bottomCheckoutBar(total);
      }),
    );
  }

  Widget _bottomCheckoutBar(int total) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        boxShadow: [
          BoxShadow(
              color: Color(0x14000000), blurRadius: 8, offset: Offset(0, -2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                  color: AppColors.brandGreen,
                  borderRadius: BorderRadius.circular(24)),
              alignment: Alignment.center,
              child: Text('₹$total',
                  style: FontUtils.bold(size: 16, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                    color: AppColors.brandGreen, width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Checkout',
                  style: FontUtils.bold(
                      size: 16, color: AppColors.textPrimary)),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceDetails extends StatelessWidget {
  final int total;
  const _PriceDetails({required this.total});

  @override
  Widget build(BuildContext context) {
    final mrpTotal = (total * 1.1).round();
    final discount = mrpTotal - total;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary',
              style:
                  FontUtils.bold(size: 16, color: AppColors.textPrimary)),
          const SizedBox(height: 10),
          _row('Price', '₹$mrpTotal'),
          const SizedBox(height: 4),
          _row('Discount', '− ₹$discount',
              valueColor: AppColors.textPrimary),
          const SizedBox(height: 4),
          _row('Delivery Charges', 'Free',
              valueColor: AppColors.brandGreen),
          const Divider(height: 20),
          _row('Total Amount', '₹$total',
              isBold: true, valueColor: AppColors.brandGreen),
          const SizedBox(height: 6),
          Text('You will save ₹$discount on this order',
              style: FontUtils.semiBold(
                  size: 12, color: AppColors.brandGreen)),
        ],
      ),
    );
  }

  Widget _row(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Row(
      children: [
        Expanded(
            child: Text(
          label,
          style: isBold
              ? FontUtils.semiBold(
                  size: 14, color: AppColors.textPrimary)
              : FontUtils.regular(
                  size: 14, color: AppColors.textPrimary),
        )),
        Text(
          value,
          style: isBold
              ? FontUtils.bold(
                  size: 14, color: valueColor ?? AppColors.textPrimary)
              : FontUtils.regular(
                  size: 14, color: valueColor ?? AppColors.textPrimary),
        ),
      ],
    );
  }
}