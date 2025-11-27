// lib/widgets/banner_slider.dart
import 'package:flutter/material.dart';
import 'package:arekatika/services/banner_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  List<dynamic> banners = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchBanners();
  }

  Future<void> _fetchBanners() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await BannerService.getBanners();
      
      if (mounted) {
        setState(() {
          isLoading = false;
          if (result['success'] == true) {
            banners = result['data']['data'] ?? [];
          } else {
            errorMessage = result['error'] ?? 'Failed to load banners';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'An error occurred: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _fetchBanners,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (banners.isEmpty) {
      return const Center(child: Text('No banners available'));
    }

    return SizedBox(
      height: 150,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: banner['imageUrl'] ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        },
      ),
    );
  }
}