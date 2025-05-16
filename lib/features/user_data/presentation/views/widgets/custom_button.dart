import 'package:flutter/material.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.bgColor,
    required this.title,
    this.onPressed,
    this.strColor,
  });

  final Color bgColor;
  final Color? strColor;
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bgColor),
        shadowColor: const WidgetStatePropertyAll(Colors.white),
        overlayColor: const WidgetStatePropertyAll(AppColors.green),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style:
            strColor != null
                ? TextStyles.regBlackTextStyle.copyWith(color: strColor)
                : TextStyles.regBlackTextStyle,
      ),
    );
  }
}
