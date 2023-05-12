import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.thirdColor,
          minimumSize: const Size(300, 50),
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          foregroundColor: AppColors.white,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.white,
      textTheme:  TextTheme(
        labelLarge:  TextStyle(
          fontFamily: 'Jost',
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF363636),
        ),
        headlineSmall: const TextStyle(
          fontSize: 26,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w500,
          color: Color(0xFF363636),
        ),
        headlineLarge: const TextStyle(
          fontSize: 28,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w500,
          color: AppColors.thirdColor,
        ),
        titleMedium: TextStyle(
          fontSize: 13.sp,
          fontFamily: 'Jost',
          color: const Color(0xFF888888),
        ),
        headlineMedium: const TextStyle(
          fontSize: 22,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w500,
          color: AppColors.thirdColor2,
        ),
        bodyLarge: const TextStyle(
          fontSize: 14,
          fontFamily: 'Roboto',
          color: Color(0xFF8D93AB),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: AppColors.secondaryColor),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.thirdColor,
          minimumSize: const Size(300, 50),
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          foregroundColor: AppColors.white,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.darkBlue,
      textTheme:  TextTheme(
        labelLarge:  TextStyle(
          fontFamily: 'Jost',
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFF5F5F5),
        ),
        headlineSmall: const TextStyle(
          fontSize: 26,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
        ),
        headlineLarge: const TextStyle(
          fontSize: 28,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w500,
          color: AppColors.thirdColor,
        ),
        titleMedium: TextStyle(
          fontSize: 13.sp,
          fontFamily: 'Jost',
          color: const Color(0xFFE0DCDC),
        ),
        headlineMedium: const TextStyle(
          fontSize: 22,
          fontFamily: 'Jost',
          fontWeight: FontWeight.w500,
          color: AppColors.thirdColor2,
        ),
        bodyLarge: const TextStyle(
          fontSize: 14,
          fontFamily: 'Roboto',
          color: Color(0xFFEAEAEE),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: AppColors.secondaryColor),
    );
  }
}
