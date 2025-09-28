import 'package:flutter/cupertino.dart';

class BottomBarIconModel {
  final Icon icon;
  final Widget widget;
  bool? isSelected;

  BottomBarIconModel({
    required this.icon,
    required this.widget,
    this.isSelected = false,
  });
}
