// lib/theme/custom_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  // Цвета
  static const Color kAppBarColor = Color.fromRGBO(245, 247, 250, 1);
  static const Color kScaffoldBackgroundColor =
      Color.fromRGBO(245, 247, 250, 1);

  // Текстовые стили
  static final TextStyle appBarTitleTextStyle = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextTheme textTheme = GoogleFonts.poppinsTextTheme(
    TextTheme(
      bodyLarge: TextStyle(fontSize: 14.sp),
      bodyMedium: TextStyle(fontSize: 14.sp),
      displayLarge: TextStyle(fontSize: 32.sp),
      displayMedium: TextStyle(fontSize: 24.sp),
      displaySmall: TextStyle(fontSize: 20.sp),
      headlineMedium: TextStyle(fontSize: 16.sp),
      headlineSmall: TextStyle(fontSize: 14.sp),
      titleLarge: TextStyle(fontSize: 12.sp),
    ),
  );

  // Тема приложения
  static ThemeData get theme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: kAppBarColor,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: appBarTitleTextStyle,
      ),
      scaffoldBackgroundColor: kScaffoldBackgroundColor,
      textTheme: textTheme,
      iconTheme: IconThemeData(
        size: 24.sp,
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }
}
