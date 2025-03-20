import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:midmate/utils/extension_fun.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/image_controller.dart';
import '../../../../../utils/text_styles.dart';
import 'custom_text_feild.dart';

class UserDataViewBody extends StatelessWidget {
  const UserDataViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(ImageController.splashImage),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(height: Context(context).height() * .07),
                  //  custom heart circle avatar
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    width: 80,
                    height: 80,
                    child: SvgPicture.asset(ImageController.heartIcon),
                  ),
                  SizedBox(height: Context(context).height() * .02),
                  const Text(
                    ' ممرضك الخاص بك ',
                    style: TextStyles.primaryBoldBlackTextStyle,
                  ),
                  SizedBox(height: Context(context).height() * .02),
                  const Text(
                    'متنساش ميعاد دواءك تاني ',
                    style: TextStyles.regGreyTextStyle,
                  ),
                  const Spacer(),

                  CustomTextFeild(hintText: 'ادخل الاسم'),
                  SizedBox(height: 15),
                  CustomTextFeild(hintText: 'العمر'),

                  SizedBox(height: Context(context).height() * .09),
                ],
              ),
            ),
          ),
        ),

        // Image.asset(ImageController.splashImage),
      ],
    );
  }
}
