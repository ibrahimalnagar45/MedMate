import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';

class PageIndecator extends StatelessWidget {
  const PageIndecator({
    super.key,
    
    required this.currentIndex,
    required this.length,

  });

  final int  currentIndex, length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentIndex ? AppColors.blue : AppColors.white),
        ),
      ),
    );
  }
}
