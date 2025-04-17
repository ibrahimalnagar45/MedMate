import 'package:flutter/material.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/text_styles.dart';

class CustomDropDownMenu<T> extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    // required this.medModel,
    this.onSelected,
    required this.entries,
    required this.hintText,
  });

  // final MedModel medModel;
  final void Function(dynamic)? onSelected;
  final List<DropdownMenuEntry<T>> entries;
  final String hintText;

  //6e b0 0c fc 99 5c
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownMenu<T>(
        
        textAlign: TextAlign.right,
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyles.hintTextStyle,
        ),
        textStyle: TextStyles.hintTextStyle,
        onSelected: onSelected,
        width: context.width() - 32,
        hintText: hintText,
        dropdownMenuEntries: entries,
      ),
    );
  }
}
