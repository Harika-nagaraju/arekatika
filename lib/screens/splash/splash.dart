import 'dart:async';
import 'package:arekatika/helper/dio_helpers.dart';
import 'package:arekatika/helper/pref_helper.dart';
import 'package:arekatika/screens/auth/login.dart';
import 'package:arekatika/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/screens/auth/introduction.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

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
      String? token = PrefHelper.getString("token");

      if (token != null && token.isNotEmpty) {
        // Set token in Dio for future APIs
        DioHelper.setToken(token);

        Get.offAll(() => Dashboard());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandOrange6339,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Image.asset('assets/images/mainlogo.png', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
