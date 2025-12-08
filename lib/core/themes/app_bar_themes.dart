import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

abstract class AppBarThemes {
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    shadowColor: Colors.black,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.black,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: AppColors.white),
  );

  static const ligthAppBarTheme = AppBarTheme(backgroundColor: AppColors.grey);
}
