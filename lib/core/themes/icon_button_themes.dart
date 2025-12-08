import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

abstract class IconButtonThemes {
  static const darkIconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(iconColor: WidgetStatePropertyAll(AppColors.teal)),
  );
  static const lightIconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(AppColors.blue),
      foregroundColor: WidgetStatePropertyAll(AppColors.blue),
    ),
  );
}
