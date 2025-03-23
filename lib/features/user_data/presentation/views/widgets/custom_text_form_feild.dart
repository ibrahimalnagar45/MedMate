import 'package:flutter/material.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/text_styles.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({super.key, this.onSubmitted, this.validator});
  final void Function(String?)? onSubmitted;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,

      onChanged: onSubmitted,
      onSaved: onSubmitted,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        filled: true,
        errorStyle: TextStyle(color: Colors.amber),
        fillColor: AppColors.grey,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),

        // hintText: _hintText,
        hintStyle: TextStyles.regBlackTextStyle,
        hintTextDirection: TextDirection.rtl,
      ),
    );
  }
}
