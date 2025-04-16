import 'package:flutter/material.dart';
import 'package:midmate/utils/app_colors.dart';

class CustomMedTypeIcon extends StatelessWidget {
  const CustomMedTypeIcon({super.key, required this.icon});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,

      backgroundColor: Colors.transparent,
      child: Image.asset(
        icon,
        fit: BoxFit.cover,
        color: AppColors.white,
        width: 35,
      ),
    );
  }
}
