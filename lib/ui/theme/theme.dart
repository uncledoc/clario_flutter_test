import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();

  static const colorBackgroundGradientStart = Color(0xFFF4F9FF);
  static const colorBackgroundGradientEnd = Color(0xFFE0EDFB);

  static const colorButtonGradientStart = Color(0xFF70C3FF);
  static const colorButtonGradientEnd = Color(0xFF4B65FF);

  static const colorError = Color(0xFFFF8080);
  static const colorErrorBackground = Color(0xFFFDEFEE);
  static const colorSuccess = Color(0xFF27B274);
  static const colorText = Color(0xFF4A4E71);

  static const colorTextHint = Color(0xFF6F91BC);
  static const colorBorderFocused = colorTextHint;

  static ThemeData buildTheme() {
    final borderRadius = BorderRadius.circular(10);
    return ThemeData(
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return AppTheme.colorErrorBackground;
          }
          return Colors.white;
        }),
        hintStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return TextStyle(color: AppTheme.colorError);
          }
          return TextStyle(color: colorTextHint);
        }),
        suffixIconColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return AppTheme.colorError;
          }
          return colorText;
        }),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBorderFocused),
          borderRadius: borderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorError),
          borderRadius: borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorError),
          borderRadius: borderRadius,
        ),
        errorStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: colorError,
        ),
      ),
    );
  }
}
