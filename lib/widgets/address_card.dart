import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class AddressCard extends StatelessWidget {
  final String name;
  final String address;
  final String phone;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const AddressCard({super.key, required this.name, required this.address, required this.phone, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 16, backgroundColor: AppColors.surface2, child: const Icon(Icons.home_rounded, color: AppColors.textPrimary, size: 16)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text(address, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text('Phone: $phone', style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF2CC),
                    foregroundColor: AppColors.textPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Edit', style: FontUtils.semiBold(size: 12, color: AppColors.textPrimary)),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 32,
                child: OutlinedButton(
                  onPressed: onDelete,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Delete', style: FontUtils.semiBold(size: 12, color: AppColors.error)),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 6),
          Text('Tap Edit to change details', style: FontUtils.regular(size: 11, color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}
