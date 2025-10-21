import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';

class PageIndecator extends StatelessWidget {
  const PageIndecator({
    super.key,

    required this.currentIndex,
    required this.length,
  });

  final int currentIndex, length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 12,
              height: 10,
              // margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: index == currentIndex ? AppColors.blue : AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
