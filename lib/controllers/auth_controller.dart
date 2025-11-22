import 'package:get/get.dart';
import 'package:arekatika/screens/dashboard/dashboard.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;

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
}