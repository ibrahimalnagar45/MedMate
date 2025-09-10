 import 'package:flutter/material.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart'; 

class AgeDropDownMenu extends StatelessWidget {
  const AgeDropDownMenu({super.key, this.onSelected});

  // final String userName;
  final void Function(String?)? onSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownMenu(
        
        width: context.width(),
        // alignment: Alignment.centerRight,
        inputDecorationTheme: InputDecorationTheme(border: InputBorder.none),
        onSelected: onSelected,
        initialSelection: '30 : 40',
        dropdownMenuEntries: [
          DropdownMenuEntry(value: "15:30", label: '15 : 30'),
          DropdownMenuEntry(value: "30:40", label: '30 : 40'),
          DropdownMenuEntry(value: "40:50", label: '40 : 50'),
          DropdownMenuEntry(value: "+50", label: '+ 50'),
        ],
      ),
    );
  }
}
