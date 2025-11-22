import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/address_card.dart';
import 'package:arekatika/screens/cart/add_new_address.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final List<Map<String, String>> _addresses = [
    {
      'name': 'Balaji',
      'address': 'H.No. 12-45, Cyber Hills, VIP Road, Hyderabad\nTelangana 500081',
      'phone': '+91 96760 10330',
    },
    {
      'name': 'Balaji',
      'address': 'Balaji Hostel , 3, ayyappa colony, Sri Sai Nagar\nMadhapur 500081',
      'phone': '+91 96760 10330',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text('Saved Addresses', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: _addresses.isEmpty ? _emptyState() : _listState(),
      ),
      bottomNavigationBar: _addButton(),
      backgroundColor: AppColors.bg,
    );
  }

  Widget _listState() {
    return ListView.builder(
      itemCount: _addresses.length,
      itemBuilder: (_, i) {
        final a = _addresses[i];
        return AddressCard(
          name: a['name']!,
          address: a['address']!,
          phone: a['phone']!,
          onEdit: () async {
            final updated = await Navigator.of(context).push<String>(
              MaterialPageRoute(builder: (_) => const AddNewAddressScreen()),
            );
            if (updated != null) {
              setState(() => _addresses[i]['address'] = updated);
            }
          },
          onDelete: () => setState(() => _addresses.removeAt(i)),
        );
      },
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.place_outlined, color: AppColors.textTertiary, size: 40),
          const SizedBox(height: 10),
          Text('No addresses yet', style: FontUtils.semiBold(size: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text('Add a new address to continue', style: FontUtils.regular(size: 12, color: AppColors.textTertiary)),
        ],
      ),
    );
  }

  Widget _addButton() {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: () async {
            final addr = await Navigator.of(context).push<String>(
              MaterialPageRoute(builder: (_) => const AddNewAddressScreen()),
            );
            if (addr != null) {
              setState(() {
                _addresses.add({'name': 'Balaji', 'address': addr, 'phone': '+91 96760 10330'});
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.brandGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          child: Text('+ Add New Address', style: FontUtils.bold(size: 14, color: Colors.white)),
        ),
      ),
    );
  }
}
