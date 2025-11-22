import 'package:flutter/material.dart';

class AppColors {
  // ======= Core Backgrounds (Light UI) =======
  static const Color bg = Color(0xFFF6F7F9); // App background behind screens
  static const Color surface = Color(0xFFFFFFFF); // Cards / sheets / dialogs
  static const Color surface2 = Color(0xFFF1F3F6); // Higher elevation / panels
  static const Color stroke = Color(0xFFE5E7EB); // Hairline borders / dividers

  // ======= Brand / Accents (from the green CTAs in shots) =======
  static const Color brandGreen = Color(
    0xFF10A64A,
  ); // Primary CTA (Send OTP / Verify / Submit)
  static const Color brandGreenPressed = Color(0xFF0E8F3F); // Pressed state
  static const Color brandGreenMuted = Color(
    0xFFE7F6EC,
  ); // Soft bg chips / disabled fill

  // Secondary accents seen in artwork & small pills
  static const Color brandOrange = Color(0xFFF59E0B);
  static const Color brandOrange2 = Color(0xFF6E39);
  static const Color brandOrange6339 = Color(0xFFFF6339);
  static const Color brandRed = Color(0xFFEF4444);
  static const Color brandBlue = Color(0xFF3B82F6);
  static const Color brandPurple = Color(0xFF9333EA);
  static const Color teal = Color(0xFF00B7C6); // Optional accent
  static const Color cyan = Color(0xFF00C6FF); // Optional accent

  // ======= Text =======
  static const Color textPrimary = Color(0xFF111827); // Titles / strong text
  static const Color textSecondary = Color(0xFF4B5563); // Body / hints
  static const Color textTertiary = Color(0xFF6B7280); // Dim captions
  static const Color textDisabled = Color(0xFF9CA3AF); // Disabled text

  // ======= Status =======
  static const Color success = brandGreen; // Success / available
  static const Color warning = brandOrange; // Warnings
  static const Color error = brandRed; // Errors
  static const Color info = brandBlue; // Informational

  // Soft backgrounds for status pills (≈15% opacity on light)
  static const Color successBg = Color(0x2610A64A); // 15% of brand green
  static const Color warningBg = Color(0x26F59E0B); // 15% of orange
  static const Color errorBg = Color(0x26EF4444); // 15% of red
  static const Color infoBg = Color(0x263B82F6); // 15% of blue

  // ======= Inputs / Overlays =======
  static const Color inputFill = Color(0xFFFFFFFF); // Filled inputs on light
  static const Color placeholder = Color(0xFF9CA3AF); // Hint text in fields
  static const Color overlayStrong = Color(0xB3000000); // ~70% black (dialogs)
  static const Color overlaySoft = Color(0x33000000); // ~20% black

  // ======= Utility Greys =======
  static const Color gray = Color(0xFF6B7280); // General grey on light
  static const Color gray1 = Color(0xFF9CA3AF); // Lighter grey
  static const Color gray2 = Color(0xFFD1D5DB); // Divider grey

  // ======= Legacy aliases (keep old names working) =======
  static const Color black = Color(0xFF000000); // Pure black
  static const Color white = Color(0xFFFFFFFF); // Pure white
  static const Color eerieBlack = bg; // Old alias → app bg (light)
  static const Color raisinBlack = surface; // Old alias → card bg (white)
  static const Color richBlack = black; // Alias to pure black

  // Map old accent names to new scheme where sensible
  static const Color jungleGreen = brandGreen; // Old name → brand green
  static const Color steelBlue = brandBlue; // Old name → info blue
  static const Color carrotOrange = warning; // Old name → warning
  static const Color fireBrick = error; // Old name → error
  static const Color mustard = warning; // Old name → warning
  static const Color goldenBrown = Color(0xFF8A6112); // Legacy preserved
  static const Color burntOrange = Color(0xFFD25120); // Optional accent
  static const Color darkGunmetal = surface2; // Old alias → elevated bg
  static const Color black1 = Color(0xFF191919); // Legacy dark
  static const Color brownish = Color(0xFF312929); // Legacy neutral
  static const Color brownish2 = Color(0xFF433B3B); // Legacy neutral
  static const Color green = success; // Legacy → success
  static const Color crimson = error; // Legacy → error
}
