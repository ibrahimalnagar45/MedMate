import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/mode_cubit/mode_cubit.dart';
import 'package:midmate/core/widgets/user_account_image.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/settings/presentaion/views/widgets/setting_item_widget.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';

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
            ListTile(
              title: SettingItemWidget(
                child: Text(
                  '${currentUser?.name ?? 'No User'}\t\t\t\t\t\t${currentUser?.birthDayDate ?? ''} ',
                  textAlign: TextAlign.center,
                ),
              ),
              leading: IconButton(
                padding: EdgeInsets.all(0),
               
                onPressed: () {
                },
                icon: Icon(Icons.edit),
              ),
            ),

            Divider(endIndent: 20, indent: 20, color: Colors.black),

            ListTile(
              title: SettingItemWidget(
                child: Text('Theme', textAlign: TextAlign.center),
              ),
              leading: Switch(
                activeThumbColor: AppColors.teal,
                value: isDarkMode,
                onChanged: (_) => context.read<ModeCubit>().toggleMode(),
              ),
            ),

            // add notification sound picker
            ListTile(
              title: SettingItemWidget(
                child: Text('Notification Sound', textAlign: TextAlign.center),
              ),
              leading: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {},
                icon: Icon(Icons.queue_music),
              ),
            ),

            Divider(endIndent: 20, indent: 20, color: Colors.black),

            // terms and policy
            SettingItemWidget(
              child: Text('Terms and Policy', textAlign: TextAlign.center),
            ),

            // about section
            SettingItemWidget(
              child: Text('About', textAlign: TextAlign.center),
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
