import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/avatar_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameCtrl = TextEditingController(text: 'BALAJI RAJANWAD');
  final _phoneCtrl = TextEditingController(text: '+91 96760 10330');
  final _emailCtrl = TextEditingController(text: 'valkontek@gmail.com');
  String gender = 'Male';
  Uint8List? _avatarBytes;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('My Profile', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          const SizedBox(height: 6),
          Center(
            child: AvatarPicker(
              radius: 38,
              onChanged: (bytes, _) => setState(() => _avatarBytes = bytes),
            ),
          ),
          const SizedBox(height: 18),

          // Full Name
          _label('Full Name'),
          _input(_nameCtrl),
          const SizedBox(height: 12),

          // Mobile Number (read-only)
          _label('Mobile Number'),
          _input(_phoneCtrl, readOnly: true),
          const SizedBox(height: 12),

          // Email
          _label('Email'),
          _input(_emailCtrl),
          const SizedBox(height: 12),

          // Gender
          _label('Gender'),
          const SizedBox(height: 6),
          Row(
            children: [
              _genderChip('Male'),
              const SizedBox(width: 18),
              _genderChip('Female'),
              const SizedBox(width: 18),
              _genderChip('Other'),
            ],
          ),

          const SizedBox(height: 20),
          SizedBox(
            height: 46,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'name': _nameCtrl.text.trim(),
                  'phone': _phoneCtrl.text.trim(),
                  'email': _emailCtrl.text.trim(),
                  'gender': gender,
                  'avatarBytes': _avatarBytes,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Save Changes', style: FontUtils.bold(size: 14, color: Colors.white)),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.bg,
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: FontUtils.semiBold(size: 12, color: AppColors.textSecondary)),
      );

  Widget _input(TextEditingController controller, {bool readOnly = false}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      enabled: !readOnly,
      style: FontUtils.regular(size: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.brandGreen),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
      ),
    );
  }

  Widget _genderChip(String value) {
    final selected = gender == value;
    return InkWell(
      onTap: () => setState(() => gender = value),
      borderRadius: BorderRadius.circular(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.brandGreen : AppColors.textTertiary, size: 18),
          const SizedBox(width: 6),
          Text(value, style: FontUtils.regular(size: 13, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
