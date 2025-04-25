import 'package:flutter/material.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/service_locator.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: AppColors.grey,
    title: Text('Home'),
    centerTitle: true,

    leading: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: CircleAvatar(
        backgroundColor: AppColors.blue,
        child: Text(
          getIt<SharedPreferences>()
              .getString(SharedPrefrenceDb.username)![0]
              .toString(),
          style: TextStyle(color: AppColors.white),
        ),
      ),
    ),

    actionsPadding: const EdgeInsets.only(right: 10),
  );
}
