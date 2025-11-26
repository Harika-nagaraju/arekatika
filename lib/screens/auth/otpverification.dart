import 'dart:async';
import 'package:arekatika/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';
import 'package:arekatika/widgets/custom_button.dart';
import 'package:arekatika/widgets/otpinput.dart';
import 'package:arekatika/screens/auth/signup.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatefulWidget {
  final int initialSeconds;

  const OtpVerificationScreen({Key? key, this.initialSeconds = 30})
    : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final phone = Get.arguments["phone"];
  final id = Get.arguments["id"];
  final TextEditingController _otpCtrl = TextEditingController();
  late int _secondsLeft = widget.initialSeconds;
  Timer? _timer;
  bool _verifying = false;
  bool _hasError = false;
  String _errorMessage = '';

  bool get _isComplete => _otpCtrl.text.length == 4;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _otpCtrl.addListener(() {
      if (_hasError) {
        setState(() => _hasError = false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpCtrl.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = widget.initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 1) {
        t.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  void _resendOtp() {
    if (_secondsLeft > 0) return;
    _authController.login(phone).then((_) {
      _startTimer();
      Get.snackbar(
        'Success',
        'OTP resent successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.brandGreen,
        colorText: Colors.white,
      );
    }).catchError((e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorRed,
        colorText: Colors.white,
      );
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.errorRed,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Incorrect OTP',
              style: FontUtils.bold(
                size: 18,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: FontUtils.regular(
                size: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandGreen,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'TRY AGAIN',
                  style: FontUtils.bold(
                    size: 14,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(24),
      ),
    );
  }

  Future<void> _verify() async {
    if (!_isComplete) return;
    
    setState(() {
      _verifying = true;
      _hasError = false;
    });

    try {
      await _authController.verifyOtp(phone, _otpCtrl.text);
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
      _showErrorDialog(_errorMessage);
    } finally {
      if (mounted) {
        setState(() => _verifying = false);
      }
    }
  }

  String _format(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final ss = (s % 60).toString().padLeft(2, '0');
    return '$m:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.overlayStrong,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background hero image
          Image.asset('assets/images/login.png', fit: BoxFit.cover),
          // Dim overlay
          Container(color: AppColors.overlayStrong),

          // Center card
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: AppColors.textPrimary,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Verify OTP',
                        style: FontUtils.bold(
                          size: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'OTP Sent to $phone',
                    style: FontUtils.regular(
                      size: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Enter OTP
                  Text(
                    'Enter OTP',
                    style: FontUtils.semiBold(
                      size: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: OtpInput(
                      controller: _otpCtrl,
                      length: 4,
                      boxSize: 44,
                      spacing: 10,
                      onCompleted: (_) => _verify(),
                      error: _hasError,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Timer + Resend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _format(_secondsLeft),
                        style: FontUtils.semiBold(
                          size: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      GestureDetector(
                        onTap: _secondsLeft == 0 ? _resendOtp : null,
                        child: Text(
                          'Resend OTP',
                          style: FontUtils.bold(
                            size: 12,
                            color: _secondsLeft == 0
                                ? AppColors.brandGreen
                                : AppColors.textDisabled,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Verify button
                  CustomButton(
                    text: 'Verify',
                    onPressed: _isComplete && !_verifying ? _verify : null,
                    isLoading: _verifying,
                    borderRadius: 8,
                    height: 44,
                    buttonColor: _hasError ? AppColors.errorRed : AppColors.brandGreen,
                  ),

                  const SizedBox(height: 12),
                  // Footer logo
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 38,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'AREKATIKA',
                          style: FontUtils.bold(
                            size: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
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