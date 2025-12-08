import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

abstract class AppSwitchTheme {
  static const darkSwitchTheme = SwitchThemeData(
   
    thumbColor: WidgetStatePropertyAll(AppColors.white),
    trackColor: WidgetStatePropertyAll(AppColors.blue),
    trackOutlineColor: WidgetStatePropertyAll(AppColors.blue),
    overlayColor: WidgetStatePropertyAll(AppColors.blue),
  );
  static const ligthSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStatePropertyAll(AppColors.white),
    trackColor: WidgetStatePropertyAll(AppColors.blue),
    trackOutlineColor: WidgetStatePropertyAll(AppColors.blue),
    overlayColor: WidgetStatePropertyAll(AppColors.blue),
  );
}
