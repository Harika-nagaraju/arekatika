import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class AvatarPicker extends StatefulWidget {
  final double radius;
  final void Function(Uint8List? bytes, XFile? xfile)? onChanged;
  const AvatarPicker({super.key, this.radius = 36, this.onChanged});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  XFile? _image;
  Uint8List? _bytes;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pick(ImageSource source) async {
    try {
      final img = await _picker.pickImage(source: source, imageQuality: 85);
      if (img != null) {
        final data = await img.readAsBytes();
        setState(() {
          _image = img;
          _bytes = data;
        });
        widget.onChanged?.call(data, img);
      }
    } catch (_) {}
  }

  void _showSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Change Profile Photo', style: FontUtils.semiBold(size: 16, color: AppColors.textPrimary)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _pick(ImageSource.camera);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.photo_camera_rounded),
                      label: Text('Camera', style: FontUtils.bold(size: 13, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _pick(ImageSource.gallery);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.brandGreen),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.photo_library_rounded, color: AppColors.brandGreen),
                      label: Text('Gallery', style: FontUtils.bold(size: 13, color: AppColors.brandGreen)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showSourceSheet,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: widget.radius,
            backgroundColor: AppColors.surface2,
            backgroundImage: _bytes != null ? MemoryImage(_bytes!) : null,
            child: _image == null
                ? Icon(Icons.person_rounded, color: AppColors.textSecondary, size: widget.radius)
                : null,
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              decoration: const BoxDecoration(color: AppColors.brandGreen, shape: BoxShape.circle),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 14),
            ),
          )
        ],
      ),
    );
  }
}
