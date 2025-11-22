import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/screens/auth/login.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pc = PageController();
  int _page = 0;

  final List<_IntroData> slides = const [
    _IntroData(
      title: 'Freshness Delivered to You',
      bullet: 'Climate-Controlled from Our Door to Yours',
      body:
          'Your meat travels in special temperature-controlled packaging that maintains perfect freshness throughout delivery. We guarantee it arrives as fresh as when it left our facility.',
    ),
    _IntroData(
      title: 'On-Demand Meat Delivery',
      bullet: 'Get Fresh Meat Within Hours',
      body:
          'Craving something specific? Order fresh cuts and get them delivered to your doorstep in just hours. Perfect for last-minute meal plans and unexpected cravings.',
    ),
    _IntroData(
      title: 'Skip the Trip',
      bullet: 'Quality Meat Without the Market Run',
      body:
          'No more traffic, parking hassles, or waiting in queues. Get the same quality you\'d find at the best meat markets delivered directly to your home at your convenience.',
    ),
    _IntroData(
      title: 'Farm Fresh Meat',
      bullet: 'Direct from Trusted Farms to You',
      body:
          'We work directly with local farms to bring you the freshest cuts available. Every order is sourced from quality farms and delivered while it\'s still at its peak freshness.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset('assets/images/mutton.png', fit: BoxFit.cover),
          ),

          // Dark gradient overlay for readability
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),

          // Content panel
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF2B2B2B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _pc,
                      onPageChanged: (i) => setState(() => _page = i),
                      itemCount: slides.length,
                      itemBuilder: (_, i) {
                        final s = slides[i];
                        return _Slide(title: s.title, bullet: s.bullet, body: s.body);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  _Dots(count: slides.length, index: _page),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.textPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('GET STARTED', style: FontUtils.bold(size: 16, color: AppColors.textPrimary)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String bullet;
  final String body;
  const _Slide({required this.title, required this.bullet, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: FontUtils.bold(size: 20, color: Colors.white)),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('• ', style: TextStyle(color: Colors.white, fontSize: 14)),
            Expanded(child: Text(bullet, style: FontUtils.semiBold(size: 14, color: Colors.white))),
          ],
        ),
        const SizedBox(height: 10),
        Text(body, style: FontUtils.regular(size: 12, color: Colors.white70)),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int index;
  const _Dots({required this.count, required this.index});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final sel = i == index;
        return Container(
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : 6),
          width: sel ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: sel ? Colors.white : Colors.white24,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}

class _IntroData {
  final String title;
  final String bullet;
  final String body;
  const _IntroData({required this.title, required this.bullet, required this.body});
}
