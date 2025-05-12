import 'package:flutter/material.dart';
import 'package:midmate/utils/text_styles.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    super.key,
    required this.title,
    this.color,
    this.isImporant = true,
  });
  final String title;
  final Color? color;
  final bool isImporant;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // textDirection: TextDirection.rtl,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              title,
              style:
                  color != null
                      ? TextStyles.regWhtieTextStyle.copyWith(color: color)
                      : TextStyles.regWhtieTextStyle,
            ),
          ),
        ),
        isImporant
            ? const Text(
              ' *',
              style: TextStyle(color: Colors.red, fontSize: 20),
            )
            : const SizedBox(),
      ],
    );
  }
}
