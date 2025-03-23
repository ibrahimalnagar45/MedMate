import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:midmate/utils/image_controller.dart';

class CustomHeartIcon extends StatelessWidget {
  const CustomHeartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      width: 80,
      height: 80,
      child: SvgPicture.asset(ImageController.heartIcon),
    );
  }
}
