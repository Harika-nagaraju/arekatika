import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/dot_indicator.dart';
import 'package:arekatika/screens/auth/login.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pc = PageController();
  int _index = 0;

  final List<_IntroData> _pages = const [
    _IntroData(
      image: 'assets/images/mutton.png',
      title: 'Freshness Delivered to You',
      bullet: 'Climate-Controlled from Our Door to Yours',
      body:
          'Your meat travels in special temperature-controlled packaging that maintains perfect freshness throughout delivery. We guarantee it arrives as fresh as when it left our facility.',
    ),
    _IntroData(
      image: 'assets/images/login.png',
      title: 'On-Demand Meat Delivery',
      bullet: 'Get Fresh Meat Within Hours',
      body:
          'Craving something specific? Order fresh cuts and get them delivered to your doorstep in just hours. Perfect for last-minute meal plans and unexpected cravings.',
    ),
    _IntroData(
      image: 'assets/images/mutton.png',
      title: 'Farm Fresh Meat',
      bullet: 'Direct from Trusted Farms to You',
      body:
          'We work directly with local farms to bring you the freshest cuts available. Every order is sourced from quality farms and delivered while it\'s still at its peak freshness.',
    ),
    _IntroData(
      image: 'assets/images/login.png',
      title: 'Skip the Trip',
      bullet: 'Quality Meat Without the Market Run',
      body:
          'No more traffic, parking hassles, or waiting in queues. Get the same quality you\'d find at the best meat markets delivered directly to your home at your convenience.',
    ),
  ];

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  void _toLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double bottomHeight = size.height * 0.42; // increase bottom portion
    final double imageHeight = size.height * 0.60; // reduce image portion

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Pages: swipe ONLY the image area; bottom content stays constant
          PageView.builder(
            controller: _pc,
            onPageChanged: (i) => setState(() => _index = i),
            itemCount: _pages.length,
            itemBuilder: (context, i) {
              final p = _pages[i];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Reduced image height
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: imageHeight,
                      width: double.infinity,
                      child: Image.asset(p.image, fit: BoxFit.cover),
                    ),
                  ),
                  // Logo chip centered over image (white circle + logo.png)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 36,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Bottom curved dark card stays fixed (constant text)
          Align(
            alignment: Alignment.bottomCenter,
            child: _BottomCard(
              height: bottomHeight,
              child: _IntroTextConstant(
                index: _index,
                count: _pages.length,
                data: _pages[_index],
                onGetStarted: _toLogin,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomCard extends StatelessWidget {
  final double height;
  final Widget child;
  const _BottomCard({required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/curve.png',
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            child: SafeArea(top: false, child: child),
          ),
        ],
      ),
    );
  }
}

class _ConcaveTopClipper extends CustomClipper<Path> {
  final double curveDepth;
  _ConcaveTopClipper({this.curveDepth = 24});

  @override
  Path getClip(Size size) {
    final Path path = Path();
    // Start bottom-left corner
    path.moveTo(0, 0);
    // Top edge with concave dip in the center
    final double w = size.width;
    final double d = curveDepth;
    path.lineTo(0, d + 16);
    path.quadraticBezierTo(w * 0.25, 0, w * 0.5, 0);
    path.quadraticBezierTo(w * 0.75, 0, w, d + 16);
    path.lineTo(w, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _IntroTextConstant extends StatelessWidget {
  final int index;
  final int count;
  final VoidCallback onGetStarted;
  final _IntroData data;

  const _IntroTextConstant({
    required this.index,
    required this.count,
    required this.data,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data.title,
          style: FontUtils.bold(size: 20, color: AppColors.white),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text('• ', style: TextStyle(color: AppColors.white, fontSize: 14)),
            Expanded(
              child: Text(
                data.bullet,
                style: FontUtils.semiBold(size: 13, color: AppColors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          data.body,
          style:
              FontUtils.regular(size: 12, color: AppColors.gray1).copyWith(height: 1.5),
        ),
        const SizedBox(height: 16),
        Center(
          child: DotsIndicator(
            count: count,
            activeIndex: index,
            size: 8,
            spacing: 10,
            activeColor: AppColors.white,
            inactiveColor: AppColors.gray,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onGetStarted,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'GET STARTED',
              style: FontUtils.bold(size: 14, color: AppColors.black),
            ),
          ),
        ),
      ],
    );
  }
}

class _IntroData {
  final String image;
  final String title;
  final String bullet;
  final String body;
  const _IntroData({
    required this.image,
    required this.title,
    required this.bullet,
    required this.body,
  });
}