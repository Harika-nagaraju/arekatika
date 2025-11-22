import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class DeliverySlotSheet extends StatefulWidget {
  const DeliverySlotSheet({super.key});

  @override
  State<DeliverySlotSheet> createState() => _DeliverySlotSheetState();
}

class _DeliverySlotSheetState extends State<DeliverySlotSheet> {
  bool isExpress = true;
  int selectedDateIndex = 0;
  String? selectedSlot;

  List<DateTime> get _dates =>
      List.generate(4, (i) => DateTime.now().add(Duration(days: i)));

  @override
  Widget build(BuildContext context) {
    final date = _dates[selectedDateIndex];
    final dateLabel = _formatDate(date);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bolt, color: AppColors.brandGreen),
                const SizedBox(width: 8),
                Text('Delivery Slot',
                    style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
            const SizedBox(height: 8),

            // Segmented control
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  _segButton(
                    text: 'Express (30–60 mins)',
                    selected: isExpress,
                    onTap: () => setState(() => isExpress = true),
                  ),
                  _segButton(
                    text: 'Schedule for Later',
                    selected: !isExpress,
                    onTap: () => setState(() => isExpress = false),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Text('Select delivery date',
                style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
            const SizedBox(height: 8),

            // Date chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_dates.length, (i) {
                  final d = _dates[i];
                  final sel = i == selectedDateIndex;
                  return Padding(
                    padding: EdgeInsets.only(right: i == _dates.length - 1 ? 0 : 8),
                    child: ChoiceChip(
                      selected: sel,
                      label: Text(_shortDate(d),
                          style: sel
                              ? FontUtils.semiBold(size: 12, color: AppColors.brandGreen)
                              : FontUtils.regular(size: 12, color: AppColors.textPrimary)),
                      backgroundColor: AppColors.white,
                      selectedColor: AppColors.brandGreenMuted,
                      side: BorderSide(color: sel ? AppColors.brandGreen : AppColors.stroke),
                      onSelected: (_) => setState(() => selectedDateIndex = i),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 12),
            Text('Select a time slot for $dateLabel',
                style: FontUtils.semiBold(size: 13, color: AppColors.textPrimary)),
            const SizedBox(height: 8),

            // Slots grid
            _slotGrid(onSelect: (v) => setState(() => selectedSlot = v), selected: selectedSlot),

            const SizedBox(height: 12),
            if (selectedSlot != null)
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 18, color: AppColors.brandGreen),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Delivery scheduled for $dateLabel – $selectedSlot',
                      style: FontUtils.regular(size: 12, color: AppColors.brandGreen),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedSlot == null
                        ? null
                        : () => Navigator.of(context).pop('$dateLabel ($selectedSlot)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Confirm slot'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _segButton({required String text, required bool selected, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: selected
                ? FontUtils.semiBold(size: 12, color: AppColors.brandGreen)
                : FontUtils.regular(size: 12, color: AppColors.textTertiary),
          ),
        ),
      ),
    );
  }

  Widget _slotGrid({required ValueChanged<String> onSelect, required String? selected}) {
    final slots = const ['8AM - 10AM', '10AM - 12PM', '12PM - 2PM', '4PM - 6PM'];
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.6,
      ),
      itemCount: slots.length,
      itemBuilder: (_, i) {
        final s = slots[i];
        final isSel = selected == s;
        return GestureDetector(
          onTap: () => onSelect(s),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSel ? AppColors.brandGreenMuted : AppColors.white,
              border: Border.all(color: isSel ? AppColors.brandGreen : AppColors.stroke),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              s,
              style: isSel
                  ? FontUtils.semiBold(size: 12, color: AppColors.brandGreen)
                  : FontUtils.regular(size: 12, color: AppColors.textPrimary),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime d) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final wd = weekdays[(d.weekday - 1) % 7];
    final m = months[d.month - 1];
    return '$wd, ${d.day} $m';
  }

  String _shortDate(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final m = months[d.month - 1];
    return '${d.day} $m';
  }
}
