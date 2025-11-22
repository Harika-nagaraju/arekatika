import 'package:get/get.dart';

class LocationController extends GetxController {
  final isLocationEnabled = false.obs;
  final selectedAddress = ''.obs;

  Future<void> enableLocation() async {
    // TODO: implement real location enable
    isLocationEnabled.value = true;
    selectedAddress.value = 'Hyderabad';
  }

  void setSelectedAddress(String address) {
    selectedAddress.value = address;
    isLocationEnabled.value = true;
  }
}