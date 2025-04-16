import 'package:flutter/material.dart';
import 'package:midmate/utils/text_styles.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({super.key, required this.title, this.color});
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        title,
        style:
            color != null
                ? TextStyles.regWhtieTextStyle.copyWith(color: color)
                : TextStyles.regWhtieTextStyle,
      ),
    );
  }
}
