import 'package:flutter/material.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/text_styles.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({super.key, required this.hintText});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyles.regBlackTextStyle,
        hintTextDirection: TextDirection.rtl,
      ),
    );
  }
}
