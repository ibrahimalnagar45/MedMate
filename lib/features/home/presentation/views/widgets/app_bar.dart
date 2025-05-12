import 'package:flutter/material.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../utils/service_locator.dart';

AppBar buildAppBar(String screenName) {
  return AppBar(
    backgroundColor: AppColors.grey,
    title: Text(
      S.current.appBarTitle(
        screenName == 'Home' ? S.current.home : S.current.description,
      ),
    ),
    centerTitle: true,
    leading: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: CircleAvatar(
        // radius: 20,
        backgroundColor: AppColors.blue,
        child: Text(
          getIt<SharedPreferences>()
              .getString(S.current.userName(SharedPrefrenceDb.username))![0]
              .toString(),
          style: TextStyle(color: AppColors.white),
        ),
      ),
    ),
    actionsPadding: const EdgeInsets.only(right: 10),
  );
}
