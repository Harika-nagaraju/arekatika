import 'dart:async';
import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/screens/auth/introduction.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const IntroductionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandOrange6339,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Image.asset(
            'assets/images/mainlogo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
