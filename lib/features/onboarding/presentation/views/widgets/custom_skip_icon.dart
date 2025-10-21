import 'package:flutter/material.dart';
import 'package:midmate/features/user_data/presentation/views/user_data_view.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/service_locator.dart';
import '../../../../../utils/text_styles.dart';
import '../../../../home/presentation/views/home_view.dart';

class CustomSkipIcon extends StatelessWidget {
  const CustomSkipIcon({super.key, required this.currentUser});
  final Person? currentUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          width: 70,
          height: 35,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.blue),
            ),
            onPressed: () {
              getIt<SharedPreferences>().setBool(
                SharedPrefrenceDb.onBoardingVisited,
                true,
              );

              if (currentUser == null) {
                context.replaceWith(UserDataView());
              } else {
                context.replaceWith(HomeView());
              }
            },
            child: Text(
              S.of(context).skip,

              style: TextStyles.regGreyTextStyle.copyWith(
                fontSize: 15,
                color: AppColors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
