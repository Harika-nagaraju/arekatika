import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('Add New Address', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Fake map image placeholder to match layout
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/login.png', height: 180, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          Text('Delivery locations', style: FontUtils.bold(size: 16, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          _LocTile(
            title: 'Delivery Address',
            subtitle: '14-861, Old Mumbai Hwy, Greenland...',
            selected: true,
          ),
          const SizedBox(height: 6),
          _LocTile(
            title: 'Office',
            subtitle: 'Capital Park, Cyber Hills, VIP Hills...',
            selected: false,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddressFormScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Text('Confirm & add details', style: FontUtils.bold(size: 14, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _LocTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  const _LocTile({required this.title, required this.subtitle, required this.selected});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<bool>(value: true, groupValue: selected, onChanged: (_) {}, activeColor: AppColors.brandGreen),
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
      ],
    );
  }
}

class AddressFormScreen extends StatelessWidget {
  const AddressFormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ctrl = List.generate(6, (_) => TextEditingController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('Enter address details', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field('Full Name', ctrl[0]),
          _field('Mobile Number', ctrl[1], keyboard: TextInputType.phone),
          _field('Flat / House / Building', ctrl[2]),
          _field('Street / Locality', ctrl[3]),
          _field('Landmark (optional)', ctrl[4]),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: const [
            _TypeChip(text: 'Home'), _TypeChip(text: 'Work'), _TypeChip(text: 'Other')
          ]),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop('Capital Park, Cyber Hills, VIP Hills...'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Text('Save Address', style: FontUtils.bold(size: 14, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _field(String hint, TextEditingController c, {TextInputType? keyboard}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.stroke),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.stroke),
          ),
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String text;
  const _TypeChip({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.brandGreenMuted,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.brandGreen),
      ),
      child: Text(text, style: FontUtils.semiBold(size: 12, color: AppColors.brandGreen)),
    );
  }
}
