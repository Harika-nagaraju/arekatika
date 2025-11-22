import 'package:flutter/material.dart';
import 'package:arekatika/screens/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arekatika',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}