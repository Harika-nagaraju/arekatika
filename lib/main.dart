import 'package:flutter/material.dart';
import 'package:arekatika/screens/splash/splash.dart';
import 'package:arekatika/helper/pref_helper.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init(); // Initialize PrefHelper
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Arekatika',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
