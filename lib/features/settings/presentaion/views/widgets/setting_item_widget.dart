import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../../utils/app_colors.dart';

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({
    super.key,
    required this.child,
    this.hPadding,
    this.icon,
  });

  final Widget child;
  final Widget? icon;

  final double? hPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      // height: 35,
      margin: EdgeInsets.symmetric(horizontal: hPadding ?? 22, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        // dense: true,
        minTileHeight: 20,
        leading: icon,
        title: child,
      ),
    );
  }
}
