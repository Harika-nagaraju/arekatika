// lib/controllers/auth_controller.dart

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/helper/dio_helpers.dart';
import 'package:arekatika/helper/pref_helper.dart';
import 'package:arekatika/screens/auth/otpverification.dart';
import 'package:arekatika/screens/auth/signup.dart';
import 'package:arekatika/screens/dashboard/dashboard.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  var loading = false.obs;
  var token = "".obs;
  var error = "".obs;

  // -------------------------------------------------------------
  // GOOGLE SIGN-IN
  // -------------------------------------------------------------
  Future<void> signInWithGoogle() async {
    try {
      loading.value = true;

      // TODO: Replace with actual Google Sign-In logic.
      // Current behavior: Navigate directly to dashboard.
      Get.offAll(() => const Dashboard());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign in with Google',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorRed,
        colorText: Colors.white,
      );
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  // -------------------------------------------------------------
  // LOGIN (SEND OTP) - improved with response validation & better error handling
  // -------------------------------------------------------------
  Future<void> login(String mobile) async {
    loading.value = true;
    error.value = "";

    try {
      print('🔄 Attempting to login with mobile: $mobile');
      
      final response = await DioHelper.postData(
        endpoint: "auth/login",
        body: {"mobileNumber": mobile},
      );

      print('✅ Login response received: ${response.data}');

      // Check if the response contains the expected data
      if (response.data != null &&
          response.data['mobileNumber'] != null &&
          response.data['otp'] != null) {
        
        final mobileNumber = response.data['mobileNumber'].toString();
        final otp = response.data['otp'].toString();

        print('📱 Mobile: $mobileNumber, OTP: $otp');
        
        loading.value = false;

        Get.to(
          () => OtpVerificationScreen(),
          arguments: {"phone": mobileNumber.trim(), "id": otp},
        );
      } else {
        throw Exception('❌ Invalid response format from server: ${response.data}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ??
                         e.response?.statusMessage ??
                         e.message ??
                         'Failed to connect to the server. Please check your internet connection.';
      
      loading.value = false;
      error.value = errorMessage;

      print('❌ Login error: $errorMessage');
      
      Get.snackbar(
        'Login Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorRed,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      loading.value = false;
      error.value = 'An unexpected error occurred: $e';
      print('❌ Unexpected error: $e');
      
      Get.snackbar(
        'Error',
        error.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorRed,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }

  // -------------------------------------------------------------
  // VERIFY OTP
  // -------------------------------------------------------------
  Future<void> verifyOtp(String mobile, String otpvalue) async {
    loading.value = true;
    error.value = "";

    try {
      final res = await DioHelper.postData(
        endpoint: "auth/verify-otp",
        body: {"mobileNumber": mobile, "otp": otpvalue},
      );

      loading.value = false;

      if (res.data['message'] == 'OTP verified successfully') {
        if (res.data['user']['kyc'] == true) {
          String? tokenValue = res.data['token'];
          if (tokenValue != null) {
            DioHelper.setToken(tokenValue);
            PrefHelper.saveString("token", tokenValue);
          }
          Get.offAll(() => const Dashboard());
        } else {
          Get.offAll(() => SignUpScreen(), arguments: {"mobile": mobile});
        }
      } else {
        throw Exception('Incorrect OTP. Please try again.');
      }
    } on DioException catch (e) {
      loading.value = false;

      String errorMessage = 'Failed to verify OTP. Please try again.';
      if (e.response?.statusCode == 400) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }

      throw Exception(errorMessage);
    } catch (e) {
      loading.value = false;
      rethrow;
    }
  }

  // -------------------------------------------------------------
  // UPDATE KYC
  // -------------------------------------------------------------
  Future<bool> updateKyc({
    required String mobile,
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    String? referral,
  }) async {
    loading.value = true;
    try {
      final res = await DioHelper.postData(
        endpoint: "auth/update-kyc",
        body: {
          "mobileNumber": mobile,
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "gender": gender,
          if (referral != null && referral.isNotEmpty) "referral": referral,
        },
      );

      if (res.data['token'] != null) {
        final token = res.data['token'];
        DioHelper.setToken(token);
        PrefHelper.saveString("token", token);
        return true;
      }

      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorRed,
        colorText: Colors.white,
      );
      rethrow;
    } finally {
      loading.value = false;
    }
  }
}
