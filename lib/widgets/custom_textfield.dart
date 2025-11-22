import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixText;
  final TextInputType keyboardType;
  final bool enabled;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixText = '',
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      style: FontUtils.regular(size: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        prefixText: prefixText.isNotEmpty ? '$prefixText ' : null,
        prefixStyle: FontUtils.bold(size: 14, color: AppColors.textPrimary),
        hintText: hintText,
        hintStyle: FontUtils.regular(size: 14, color: AppColors.placeholder),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.stroke, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.brandGreen, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray2, width: 1.0),
        ),
      ),
    );
  }
}
