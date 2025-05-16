import 'package:flutter/material.dart';
 import 'package:midmate/generated/l10n.dart';
import 'package:midmate/main.dart';
import 'package:midmate/utils/app_colors.dart';
 import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../utils/extension_fun.dart';
import '../../../../../utils/service_locator.dart';
import '../../../../user_data/presentation/views/add_new_user_view.dart';

AppBar buildAppBar(String screenName, BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.grey,
    title: Text(
      S.current.appBarTitle(
        screenName == 'Home' ? S.current.home : S.current.description,
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          showMenu(
            context: context,
            items:
                users
                    .asMap()
                    .map(
                      (key, value) => MapEntry(
                        key,
                        PopupMenuItem(child: Text("value.name!")),
                      ),
                    )
                    .values
                    .toList(),
          );
        },
        icon: Icon(Icons.keyboard_arrow_down_rounded),
      ),
    ],
    leading: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          Context(context).goTo(AddNewUserView());
        },
        child: CircleAvatar(
          // radius: 20,
          backgroundColor: AppColors.blue,
          child: Text(
            getIt<SharedPreferences>()
                .getString(SharedPrefrenceDb.username)![0]
                .toString(),
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    ),
    actionsPadding: const EdgeInsets.only(right: 10),
  );
}
