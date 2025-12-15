import 'package:clone_whatsapp_round34/src/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  
  // ==============================
  // ☀️ Light Theme
  // ==============================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      fontFamilyFallback: const ['NotoSansArabic'],
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
       // 1. Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
        onPrimary: Colors.white, 
        onSurface: AppColors.textPrimaryLight, 
      ),

      // 2. AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0, 
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: AppTextStyles.headlineMedium.copyWith(
          color: Colors.white,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, 
        ),
      ),

      // 3. TabBar Theme (التصحيح هنا: استخدام TabBarThemeData)
      tabBarTheme: const TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xB3FFFFFF), 
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),

      // 4. Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary, // لون الزر
    foregroundColor: Colors.white,       // لون النص
    shadowColor: Colors.grey.shade400,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    textStyle: AppTextStyles.bodyMedium.copyWith(
      fontWeight: FontWeight.bold,
    ),
  ),
),

      // 5. Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.textPrimaryLight),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.textPrimaryLight),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimaryLight),
        titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimaryLight),
        titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimaryLight),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimaryLight),
        labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimaryLight),
        labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondaryLight), 
        labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondaryLight), 
      ),

      // 6. Input Decoration
inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: Colors.white, // خلفية الحقل
  hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondaryLight),
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
    borderSide: BorderSide(color: Colors.grey.shade300), // ضع حد رمادي فاتح
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
    borderSide: BorderSide(color: Colors.grey.shade300), // حد عند الحالة العادية
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
    borderSide: BorderSide(color: AppColors.primary, width: 2), // حد عند التركيز
  ),
),
 
      
      // 7. Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.textSecondaryLight,
      ),
    );
  }

  // ==============================
  // 🌑 Dark Theme
  // ==============================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto', 
      fontFamilyFallback: const ['NotoSansArabic'], 
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      
      // 1. Color Scheme Dark
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSurface: AppColors.textPrimaryDark,
      ),
elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondary,
    foregroundColor: Colors.white,
    shadowColor: Colors.black54,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    textStyle: AppTextStyles.bodyMedium.copyWith(
      fontWeight: FontWeight.bold,
    ),
  ),
),

      // 2. AppBar Theme Dark
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark, 
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textSecondaryDark),
        actionsIconTheme: const IconThemeData(color: AppColors.textSecondaryDark),
        titleTextStyle: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.textPrimaryDark, 
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),

      // 3. TabBar Theme Dark (التصحيح هنا: استخدام TabBarThemeData)
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.primary, 
        unselectedLabelColor: AppColors.textSecondaryDark,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      // 4. FAB Dark
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary, 
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      ),

      // 5. Text Theme Dark
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.textPrimaryDark),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.textPrimaryDark),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimaryDark),
        titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimaryDark),
        titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimaryDark),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimaryDark),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimaryDark),
        labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimaryDark),
        labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondaryDark),
        labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondaryDark),
      ),

      // 6. Input Decoration Dark
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark, 
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondaryDark),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide.none,
        ),
      ),

      // 7. Icon Theme Dark
      iconTheme: const IconThemeData(
        color: AppColors.textSecondaryDark,
      ),
    );
  }
}