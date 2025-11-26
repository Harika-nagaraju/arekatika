import 'package:arekatika/screens/auth/otpverification.dart';
import 'package:arekatika/screens/auth/signup.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:arekatika/screens/dashboard/dashboard.dart';
import 'package:arekatika/helper/dio_helpers.dart';
import 'package:arekatika/helper/pref_helper.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  var loading = false.obs;
  var token = "".obs;
  var error = "".obs;

  Future<void> signInWithGoogle() async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(() => const Dashboard());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String mobile) async {
    loading.value = true;
    error.value = "";

    try {
      final res = await DioHelper.postData(
        endpoint: "auth/login",
        body: {"mobileNumber": mobile},
      );

      var mobileNumber = res.data['mobileNumber'];
      var otp = res.data['otp'];

      print(res.data);
      loading.value = false;

      // Navigate to Home
      Get.to(
        () => OtpVerificationScreen(),
        arguments: {"phone": mobileNumber.trim(), "id": otp},
      );
    } catch (e) {
      loading.value = false;
      error.value = "Login failed: $e";
      print(error.value);
    }
  }

  Future<void> verifyOtp(String mobile, String otpvalue) async {
    loading.value = true;
    error.value = "";

    try {
      final res = await DioHelper.postData(
        endpoint: "auth/verify-otp",
        body: {"mobileNumber": mobile, "otp": otpvalue},
      );

      loading.value = false;
      // print("✅ OTP Verified: ${res.data}");
      // {message: OTP verified successfully, user: {id: 6921f4377ac7bdfa4e73ca29, firstName: null, lastName: null, email: null, mobileNumber: 9395148149, kyc: false}}

      if (res.data['user']['kyc'] == true) {
        String? token = res.data['token'];
        if (token != null) {
          DioHelper.setToken(token);
          PrefHelper.saveString("token", token);
        }
        Get.offAll(() => const Dashboard());
        return;
      } else {
        Get.offAll(() => SignupScreen(), arguments: {"mobile": mobile});
      }
    } catch (e) {
      loading.value = false;

      if (e is DioException) {
        print("❌ Status: ${e.response?.statusCode}");
        print("❌ Error Response: ${e.response?.data}");
        print("❌ URL: ${e.requestOptions.uri}");
      }

      error.value = "Login failed: $e";
    }
  }

  Future<bool> updateKyc({
    required String mobile,
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    required String referral,
  }) async {
    loading.value = true;
    error.value = "";

    try {
      final res = await DioHelper.postData(
        endpoint: "auth/update-kyc",
        body: {
          "mobileNumber": mobile,
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "gender": gender,
          "reffaral": referral,
        },
      );

      loading.value = false;
      print("KYC Updated: ${res.data}");

      String? token = res.data['token'];
      if (token != null) {
        DioHelper.setToken(token);
        PrefHelper.saveString("token", token);
      }

      // Check success status
      bool status = res.data["status"] ?? true;
      if (status) {
        Get.offAll(() => const Dashboard());
      }

      return status; // return true or false
    } catch (e) {
      loading.value = false;

      if (e is DioException) {
        print("❌ Status: ${e.response?.statusCode}");
        print("❌ Response: ${e.response?.data}");
      }

      error.value = "KYC Update failed: $e";
      return false;
    }
  }
}
