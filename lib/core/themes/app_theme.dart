import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import 'app_bar_themes.dart';
import 'icon_button_themes.dart';
import 'icon_themes.dart';
import 'switch_themes.dart';

abstract class AppTheme {
  static ThemeData buildDarkTheme() {
    final base = ThemeData.dark();

    return base.copyWith(
      // 1️⃣ Text colors
      textTheme: base.textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
        decorationColor: Colors.black,
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),

      scaffoldBackgroundColor: AppColors.scaffoldDarkBgColor,
      primaryColor: AppColors.blue,
      appBarTheme: AppBarThemes.darkAppBarTheme,
      iconTheme: IconThemes.darkIconTheme,
      iconButtonTheme: IconButtonThemes.darkIconButtonTheme,
      switchTheme: AppSwitchTheme.darkSwitchTheme,
      // cardColor, dividerColor, bottomNavigationBarTheme, etc.
    );
  }

  static ThemeData buildLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldLightBgColor,
      fontFamily: AppFonts.primaryFont,
      iconButtonTheme: IconButtonThemes.lightIconButtonTheme,
      appBarTheme: AppBarThemes.ligthAppBarTheme,
      switchTheme: AppSwitchTheme.ligthSwitchTheme,
      primaryColor: AppColors.blue,
      iconTheme: IconThemes.lightIconTheme,
    );
  }
}
