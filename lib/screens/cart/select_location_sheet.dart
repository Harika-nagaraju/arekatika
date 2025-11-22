import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class SelectDeliveryLocationSheet extends StatelessWidget {
  final VoidCallback onAddNew;
  const SelectDeliveryLocationSheet({super.key, required this.onAddNew});

  @override
  Widget build(BuildContext context) {
    String? selected;

    return StatefulBuilder(
      builder: (context, setState) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.place_outlined, color: AppColors.brandGreen),
                    const SizedBox(width: 8),
                    Text('Select delivery location',
                        style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
                const SizedBox(height: 8),

                _radioTile(
                  context,
                  title: 'Delivery Address',
                  subtitle: 'No address added yet',
                  value: 'address',
                  groupValue: selected,
                  onChanged: (v) => setState(() => selected = v),
                  trailing: TextButton(onPressed: onAddNew, child: const Text('Select')),
                ),
                const Divider(),
                _radioTile(
                  context,
                  title: 'Delivery Slot',
                  subtitle: 'No slot selected yet',
                  value: 'slot',
                  groupValue: selected,
                  onChanged: (v) => setState(() => selected = v),
                  trailing: TextButton(
                    onPressed: () => Navigator.of(context).pop('Slot: 8AM–10AM'),
                    child: const Text('Select'),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _radioTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
    required Widget trailing,
  }) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.brandGreen,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: FontUtils.semiBold(size: 14, color: AppColors.textPrimary)),
              const SizedBox(height: 2),
              Text(subtitle, style: FontUtils.regular(size: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
        trailing,
      ],
    );
  }
}
