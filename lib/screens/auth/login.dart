import 'dart:async';
import 'package:arekatika/widgets/dot_indicator.dart';
import 'package:arekatika/screens/auth/otpverification.dart';
import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/screens/dashboard/dashboard.dart';
import 'package:get/get.dart';
import 'package:arekatika/controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _HeroImage extends StatelessWidget {
  final String path;
  const _HeroImage({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(path, fit: BoxFit.cover);
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneCtrl = TextEditingController();
  bool agreed = false;
  late final PageController _pageCtrl;
  int _page = 0;
  Timer? _autoScrollTimer;

  final AuthController _authController = Get.put(AuthController());

  bool get _validPhone {
    final t = phoneCtrl.text.replaceAll(RegExp(r'\D'), '');
    return t.length >= 10;
  }

  bool get _canSendOtp => _validPhone && agreed;

  void _sendOtp() {
    _authController.login(phoneCtrl.text.trim());
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) => OtpVerificationScreen(
    //       phoneNumber: phoneCtrl.text.trim(),
    //     ),
    //   ),
    // );
  }

  Future<void> _continueWithGoogle() async {
    await _authController.signInWithGoogle();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const Dashboard()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    phoneCtrl.addListener(() => setState(() {}));
    _pageCtrl = PageController();
    _pageCtrl.addListener(() {
      final p = _pageCtrl.page?.round() ?? 0;
      if (p != _page) setState(() => _page = p);
    });

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || !_pageCtrl.hasClients) return;
      final nextPage = (_page + 1) % 5;
      _pageCtrl.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Increase/decrease this factor to control hero height
    final double heroHeight =
        size.height * 0.42; // slightly reduced for better balance

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===== HERO CAROUSEL (taller + fills width) =====
            SizedBox(
              height: heroHeight,
              width: size.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PageView(
                    controller: _pageCtrl,
                    children: const [
                      _HeroImage(path: 'assets/images/login.png'),
                      _HeroImage(path: 'assets/images/login2.png'),
                      _HeroImage(path: 'assets/images/login3.png'),
                      _HeroImage(path: 'assets/images/login4.png'),
                      _HeroImage(path: 'assets/images/login5.png'),
                    ],
                  ),
                  // Headline centered in hero
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(bottom: 32),
                  //     child: Text(
                  //       "Hyderabad's Premium\nGoat & Mutton Cuts",
                  //       textAlign: TextAlign.center,
                  //       style: FontUtils.bold(
                  //         size: 22,
                  //         color: AppColors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Dots near bottom like the mock
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DotsIndicator(
                        count: 5,
                        activeIndex: _page,
                        size: 8,
                        spacing: 10,
                        activeColor: AppColors.brandGreen,
                        inactiveColor: AppColors.gray2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ===== FORM BLOCK =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Sign Up / Log In',
                    style: FontUtils.bold(
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Phone field with 91+ prefix
                  TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    style: FontUtils.regular(
                      size: 14,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      hintStyle: FontUtils.regular(
                        size: 14,
                        color: AppColors.placeholder,
                      ),
                      prefixText: '91+ ',
                      prefixStyle: FontUtils.bold(
                        size: 14,
                        color: AppColors.textPrimary,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.stroke,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.brandGreen,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Terms row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: agreed,
                          onChanged: (v) => setState(() => agreed = v ?? false),
                          side: const BorderSide(
                            color: AppColors.stroke,
                            width: 1,
                          ),
                          activeColor: AppColors.brandGreen,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: FontUtils.regular(
                              size: 12,
                              color: AppColors.textSecondary,
                            ).copyWith(height: 1.4),
                            children: [
                              const TextSpan(
                                text:
                                    'By registering, you Confirm that you Accept ',
                              ),
                              TextSpan(
                                text: 'Our agree to the Terms & Privacy.',
                                style: FontUtils.bold(
                                  size: 12,
                                  color: AppColors.brandGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Send OTP button
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _canSendOtp ? _sendOtp : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _canSendOtp
                            ? AppColors.brandGreen
                            : AppColors.brandGreenMuted,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Send OTP'.toUpperCase(),
                        style: FontUtils.bold(size: 13, color: AppColors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Divider "Or"
                  Row(
                    children: [
                      const Expanded(child: Divider(color: AppColors.gray2)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Or',
                          style: FontUtils.regular(
                            size: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: AppColors.gray2)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Continue with Google
                  Obx(() {
                    return SizedBox(
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: _authController.isLoading.value
                            ? null
                            : _continueWithGoogle,
                        icon: Image.asset(
                          'assets/images/google.png',
                          width: 18,
                          height: 18,
                        ),
                        label: Text(
                          _authController.isLoading.value
                              ? 'Signing in...'
                              : 'Continue With Google',
                          style: FontUtils.bold(
                            size: 13,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: AppColors.stroke,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: AppColors.white,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 18),

                  // Powered by
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: FontUtils.regular(
                          size: 12,
                          color: AppColors.textTertiary,
                        ),
                        children: [
                          const TextSpan(text: 'Powered by '),
                          TextSpan(
                            text: 'Valkontek',
                            style: FontUtils.bold(
                              size: 12,
                              color: AppColors.brandOrange6339,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
