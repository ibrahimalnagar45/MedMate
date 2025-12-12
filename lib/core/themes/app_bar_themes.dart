import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

abstract class AppBarThemes {
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    shadowColor: Colors.transparent,

    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.blue),
    actionsIconTheme: IconThemeData(color: AppColors.blue),
    titleTextStyle: TextStyle(color: AppColors.white),
  );

  static const ligthAppBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
  );
}
