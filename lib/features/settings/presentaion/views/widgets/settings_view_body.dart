import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/mode_cubit/mode_cubit.dart';
import 'package:midmate/core/widgets/user_account_image.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/settings/presentaion/views/widgets/setting_item_widget.dart';
import 'package:midmate/features/settings/presentaion/views/widgets/terms_view.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
import '../../../../../generated/l10n.dart';
import 'about_me_view.dart';

/*
 User info (photo, name, birthday, edit)       Done 

Display settings (theme, font, colors)

Language & region (Arabic/English toggle)

Reminders & notifications (sound, snooze, toggle)

Privacy & data (reset, clear data)

About app (version, developer info)
 */
class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  Person? currentUser;
  bool isDarkMode = false;

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  bool focused = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocBuilder<ModeCubit, ModeState>(
      builder: (context, state) {
        final isDarkMode = (state is Modechanged && state.mode == 'dark');

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            UserAccountImage(
              currentUser: currentUser,
              radius: size.height * .05,
            ),
            SizedBox(height: size.height * .04),

            // name and birthday section
            ListTile(
              title: Center(
                child: TextField(
                  canRequestFocus: focused,
                  autofocus: focused,
                  selectAllOnFocus: focused,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    fillColor: AppColors.white,
                    focusColor: AppColors.white,
                    hoverColor: AppColors.white,
                    hint: Text(
                      '${currentUser?.name ?? 'No User'}\t\t\t\t\t\t${currentUser?.birthDayDate ?? ''} ',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              leading: IconButton(
                padding: EdgeInsets.all(0),

                onPressed: () {
                  setState(() {
                    focused = true;
                  });
                },
                icon: Icon(Icons.edit, color: AppColors.blue),
              ),
            ),

            // ListTile(
            //   title: SettingItemWidget(
            //     child: Text(
            //       '${currentUser?.name ?? 'No User'}\t\t\t\t\t\t${currentUser?.birthDayDate ?? ''} ',
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            //   leading: IconButton(
            //     padding: EdgeInsets.all(0),
            //     onPressed: () {},
            //     icon: Icon(Icons.edit),
            //   ),
            // ),
            Divider(endIndent: 20, indent: 20, color: Colors.black),

            SettingItemWidget(
              icon: Switch(
                activeThumbColor: AppColors.teal,
                value: isDarkMode,
                onChanged: (_) => context.read<ModeCubit>().toggleMode(),
              ),
              child: Text(
                S.current.theme,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),

            // add notification sound picker
            SettingItemWidget(
              icon: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {},
                icon: Icon(Icons.queue_music, color: AppColors.blue),
              ),
              child: Text(
                S.current.NotificationSound,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),

            Divider(endIndent: 20, indent: 20, color: Colors.black),

            // terms and policy
            SettingItemWidget(
              onTap: () => Context(context).goTo(TermView()),
              icon: Icon(Icons.list_alt_rounded, color: AppColors.blue),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  S.current.TermsAndPolicySection,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),

            // about section
            SettingItemWidget(
              onTap: () => Context(context).goTo(AboutMeView()),
              icon: Icon(Icons.info_outline_rounded, color: AppColors.blue),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),

                child: Text(
                  S.current.AboutSection,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            //
          ],
        );
      },
    );

    return Column(
      // mainAxisAlignment: ma,
      children: [
        UserAccountImage(currentUser: currentUser),

        SettingItemWidget(
          child: Text(
            '${currentUser?.name ?? 'No User'}\t\t\t\t\t\t${currentUser?.birthDayDate ?? ''} ',
            textAlign: TextAlign.center,
          ),
        ),
        Divider(endIndent: 20, indent: 20, color: AppColors.white),
        SettingItemWidget(child: Text('Theme', textAlign: TextAlign.left)),

        SwitchListTile(
          activeThumbColor: AppColors.blue,

          title: Text('Theme', textAlign: TextAlign.left),
          value: isDarkMode,
          onChanged: (value) {
            isDarkMode = value;
            setState(() {});
            context.read<ModeCubit>().toggleMode();
          },
        ),
      ],
    );
  }

  void _getCurrentUser() async {
    currentUser = await getIt<UserRepository>().getCurrentUser();
    setState(() {});
  }
}
