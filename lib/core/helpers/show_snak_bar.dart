import 'package:flutter/material.dart';
import 'package:midmate/main.dart';
import 'package:midmate/utils/app_colors.dart';

showSnakBar(String message) {
  scaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      backgroundColor: AppColors.blue,
      content: Center(child: Text(message)),
      duration: const Duration(seconds: 3),
    ),
  );
}
