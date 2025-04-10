import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midmate/features/user_data/presentation/views/user_data_view.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/shared_prefrence_db.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/service_locator.dart';
import '../../../../../utils/text_styles.dart';
import '../../../../home/presentation/views/home_view.dart';

class CustomSkipIcon extends StatelessWidget {
  const CustomSkipIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.green),
          ),
          onPressed: () {
            getIt<SharedPreferences>().setBool(
              SharedPrefrenceDb.onBoardingVisited,
              true,
            );
            debugPrint(
              'from custom icon the value SharedPrefrenceDb.onBoardingVisited is ${getIt<SharedPreferences>().getBool(SharedPrefrenceDb.onBoardingVisited)}',
            );
            if (getIt<UserModel>().getUser().name == '') {
              context.replaceWith(UserDataView());
            } else {
              context.replaceWith(HomeView());
            }
          },
          child: Text(
            'تخطي',
            style: TextStyles.regGreyTextStyle.copyWith(
              fontSize: 20,
              color: AppColors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
