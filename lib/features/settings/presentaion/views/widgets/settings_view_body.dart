import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/mode_cubit/mode_cubit.dart';
import 'package:midmate/core/widgets/user_account_image.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/settings/presentaion/views/widgets/setting_item_widget.dart';
import 'package:midmate/utils/app_colors.dart';

import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';

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
    return BlocBuilder<ModeCubit, ModeState>(
      builder: (context, state) {
        final isDarkMode = (state is Modechanged && state.mode == 'dark');

        return Column(
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
              title: const Text('Theme'),
              value: isDarkMode,
              onChanged: (_) => context.read<ModeCubit>().toggleMode(),
            ),
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
