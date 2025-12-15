import 'package:flutter/material.dart';

class AppTextStyles {
  // يفضل استخدام Google Fonts لاحقاً، حالياً سنعتمد الخط الافتراضي للنظام
  static const String fontFamily = 'Roboto';
  static const String fontFamilyArabic = 'NotoSansArabic'; 

  // --- Headings (العناوين الكبيرة) ---
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.w600, // SemiBold
    height: 1.2,
  );

  // --- Titles (عناوين القوائم والبارات) ---
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w500, // Medium
    height: 1.2,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  // --- Body (نصوص المحادثات والوصف) ---
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    height: 1.5, // مسافة مريحة للقراءة في الشات
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  // --- Labels (النصوص الصغيرة، الأزرار، التواريخ) ---
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  );
}