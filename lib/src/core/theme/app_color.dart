import 'package:flutter/material.dart';

class AppColors {
  // --- Brand Colors (الألوان الرئيسية) ---
  static const Color primary = Color(0xFF00A884); // لون الواتساب الأخضر الشهير
  static const Color secondary = Color(0xFF008069); // الأخضر الداكن (للشريط العلوي)
  static const Color accent = Color(0xFF25D366); // لون أيقونة الواتساب الفاتح

  // --- Backgrounds (الخلفيات) ---
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF111B21); // خلفية الدارك مود
  
  static const Color chatBackgroundLight = Color(0xFFEFE7DE); // خلفية الشات البيج
  static const Color chatBackgroundDark = Color(0xFF0B141A); // خلفية الشات في الدارك مود

  // --- Surfaces (البطاقات والقوائم) ---
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF202C33); // لون القوائم والبار العلوي في الدارك

  // --- Text Colors (النصوص) ---
  static const Color textPrimaryLight = Color(0xFF111B21);
  static const Color textSecondaryLight = Color(0xFF667781); // للنصوص الفرعية والوقت
  
  static const Color textPrimaryDark = Color(0xFFE9EDEF);
  static const Color textSecondaryDark = Color(0xFF8696A0);

  // --- Chat Bubbles (فقاعات الشات) ---
  static const Color myMessageBubbleLight = Color(0xFFD9FDD3); // رسالتي (أخضر فاتح)
  static const Color otherMessageBubbleLight = Color(0xFFFFFFFF); // رسالة الطرف الآخر
  
  static const Color myMessageBubbleDark = Color(0xFF005C4B); // رسالتي (دارك)
  static const Color otherMessageBubbleDark = Color(0xFF202C33); // رسالة الطرف الآخر (دارك)

  // --- Status & Errors ---
  static const Color error = Color(0xFFEA0038);
  static const Color success = Color(0xFF00A884);
}