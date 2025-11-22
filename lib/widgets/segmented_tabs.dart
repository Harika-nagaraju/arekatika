import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class SegmentedTabs extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final EdgeInsetsGeometry padding;
  const SegmentedTabs({super.key, required this.labels, required this.selectedIndex, required this.onChanged, this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 8)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          for (int i = 0; i < labels.length; i++) ...[
            _SegChip(
              text: labels[i],
              selected: selectedIndex == i,
              onTap: () => onChanged(i),
            ),
            if (i != labels.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _SegChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;
  const _SegChip({required this.text, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.brandGreen : AppColors.surface2,
          borderRadius: BorderRadius.circular(20),
          border: selected ? null : Border.all(color: AppColors.stroke),
        ),
        child: Text(
          text,
          style: selected
              ? FontUtils.semiBold(size: 12, color: AppColors.white)
              : FontUtils.regular(size: 12, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
