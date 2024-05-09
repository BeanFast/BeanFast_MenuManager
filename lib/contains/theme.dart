import 'package:beanfast_menumanager/contains/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'theme_color.dart';

class AppTheme {
  static ThemeData defaulTheme = ThemeData(
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: ThemeColor.bgColor,
    primaryColor: ThemeColor.primaryColor,
    textTheme: DTextTheme.textTheme,
    listTileTheme: ListTileThemeData(
      titleTextStyle: Get.textTheme.bodyMedium,
      subtitleTextStyle:
          Get.textTheme.bodySmall!.copyWith(color: Colors.black54),
      leadingAndTrailingTextStyle: Get.textTheme.bodyMedium,
      selectedColor: ThemeColor.inputColor,
    ),

    highlightColor: ThemeColor.primaryColor,
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) =>
          const Icon(Iconsax.arrow_left_2),
    ),
    appBarTheme: AppBarTheme(
      color: ThemeColor.bgColor2,
      surfaceTintColor: ThemeColor.bgColor2,
      shadowColor: ThemeColor.bgColor2,
      elevation: 3,
      titleTextStyle: DTextTheme.textTheme.titleLarge!
          .copyWith(color: Colors.black, fontSize: 20),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeColor.inputColor, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      labelStyle: Get.textTheme.bodyMedium,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeColor.inputColor, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeColor.inputColor, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ThemeColor.bgColor2),
        foregroundColor: MaterialStateProperty.all(ThemeColor.inputColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.black, width: 0.5),
          ),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(backgroundColor: ThemeColor.bgColor),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: ThemeColor.bgColor,
      indicatorColor: ThemeColor.primaryColor,
    ),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: ThemeColor.bgColor),

    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   extendedTextStyle: TextStyle(color: ThemeColor.inputColor),
    //   backgroundColor: ThemeColor.bgColor2,
    //   elevation: 0.8,
    //   hoverElevation: 1,
    // ),
    cardTheme: CardTheme(
      color: ThemeColor.bgColor2,
      surfaceTintColor: ThemeColor.bgColor2,
      shadowColor: ThemeColor.bgColor2,
      elevation: 1,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: ThemeColor.bgColor,
      surfaceTintColor: ThemeColor.bgColor,
      shadowColor: ThemeColor.bgColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
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