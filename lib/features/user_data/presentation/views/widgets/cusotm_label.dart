import 'package:flutter/material.dart';
import 'package:midmate/utils/text_styles.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(title, style: TextStyles.regWhtieTextStyle),
    );
  }
}
