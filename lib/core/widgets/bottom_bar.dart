import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midmate/core/models/bottom_bar_icon_model.dart';
import 'package:midmate/features/chart/presentaion/views/chart_view.dart';
import 'package:midmate/features/home/presentation/views/home_view.dart';
import 'package:midmate/features/home/presentation/views/today_meds.dart';
import 'package:midmate/utils/app_colors.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  List<BottomBarIconModel> bottomBarIcons = [
    BottomBarIconModel(
      icon: Icon(Icons.stacked_bar_chart_rounded, color: AppColors.blue),
      widget: ChartView(),
      isSelected: false,
    ),
    BottomBarIconModel(
      icon: Icon(Icons.today, color: AppColors.blue),
      widget: MedsToday(),
      isSelected: false,
    ),
    BottomBarIconModel(
      icon: Icon(Icons.home),
      widget: HomeView(),
      isSelected: true,
    ),
  ];
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: Colors.transparent,
      elevation: 0,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: List.generate(bottomBarIcons.length, (index) {
          return GestureDetector(
            onTap: () {
              bottomBarIcons[index].isSelected =
                  !bottomBarIcons[index].isSelected!;
              setState(() {});
            },
            child: BottomBarItem(
              icon: bottomBarIcons[index].icon,
              isSelected: false,
              onPressed: () {
                // currentIndex = index;
                // setState(() {});
                // bottomBarIcons[index].isSelected =
                //     !bottomBarIcons[index].isSelected!;
                // setState(() {});
                goTo(context, bottomBarIcons[index].widget);
              },
            ),
          );
        }),
      ),
    );
  }

  goTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    super.key,
    required this.icon,
    this.onPressed,

    this.isSelected = false,
  });
  final Icon icon;
  final void Function()? onPressed;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          isSelected! ? AppColors.green : Colors.transparent,
        ),
      ),
    );
  }
}
