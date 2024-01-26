import 'package:flutter/material.dart';

import 'theme_color.dart';

class AppTheme {
  static ThemeData defaulTheme = ThemeData(
    scaffoldBackgroundColor: ThemeColor.bgColor, // Màu nền của scaffold
    primaryColor: ThemeColor.primaryColor, // Màu chính của ứng dụng
    primaryTextTheme: TextTheme(
      headlineSmall: TextStyle(color: ThemeColor.textColor),
      titleSmall: TextStyle(color: ThemeColor.textColor, fontSize: 16),
      bodySmall: TextStyle(color: ThemeColor.textColor, fontSize: 13),
    ),
    appBarTheme: AppBarTheme(color: ThemeColor.bgColor2),
    snackBarTheme: SnackBarThemeData(backgroundColor: ThemeColor.bgColor),
    navigationRailTheme: NavigationRailThemeData(backgroundColor: ThemeColor.bgColor),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: ThemeColor.bgColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: ThemeColor.bgColor),
    cardTheme: CardTheme(color: ThemeColor.bgColor2),
  );
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.indigo,
    // accentColor: Colors.orange,
    scaffoldBackgroundColor: ThemeColor.bgColor,
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.indigo,
    // accentColor: Colors.orange,
    scaffoldBackgroundColor:
        ThemeColor.bgColor, // Màu nền của scaffold trong chủ đề tối
    // Các thuộc tính khác của chủ đề tối
  );
}

    // return ThemeData(
    //   colorScheme: colorScheme,
    //   brightness: colorScheme.brightness,
    //   primaryColor: primarySurfaceColor,
    //   canvasColor: colorScheme.background,
    //   scaffoldBackgroundColor: colorScheme.background,
    //   bottomAppBarColor: colorScheme.surface,
    //   cardColor: colorScheme.surface,
    //   dividerColor: colorScheme.onSurface.withOpacity(0.12),
    //   backgroundColor: colorScheme.background,
    //   dialogBackgroundColor: colorScheme.background,
    //   indicatorColor: onPrimarySurfaceColor,
    //   errorColor: colorScheme.error,
    //   textTheme: textTheme,
    //   applyElevationOverlayColor: isDark,
    //   useMaterial3: useMaterial3,
    // );