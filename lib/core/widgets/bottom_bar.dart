import 'package:flutter/material.dart';
import 'package:midmate/features/chart/presentaion/views/chart_view.dart';
import 'package:midmate/features/home/presentation/views/home_view.dart';
import 'package:midmate/features/home/presentation/views/today_meds.dart';
import 'package:midmate/utils/app_colors.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      color: Colors.transparent,
      elevation: 0,
      // shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomBarItem(
            icon: Icon(Icons.stacked_bar_chart_rounded, color: AppColors.blue),
            onPressed: () => GoTo(context, ChartView()),
          ),
          BottomBarItem(
            icon: Icon(Icons.today, color: AppColors.blue),
            onPressed: () => GoTo(context, MedsToday()),
          ),

          BottomBarItem(
            icon: Icon(Icons.home, color: AppColors.blue),
            onPressed: () => GoTo(context, HomeView()),
          ),
        ],
      ),
    );
  }

  GoTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({super.key, required this.icon, this.onPressed});
  final Icon icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: icon);
  }
}
