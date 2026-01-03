import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/language_cubit/language_cubit.dart';
import 'package:midmate/utils/extension_fun.dart';

import '../../../../../core/managers/mode_cubit/mode_cubit.dart';
import '../../../../../core/services/local_notification.dart';
import '../../../../../core/widgets/user_account_image.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../main.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/models/user_model.dart';
import '../../../../../utils/service_locator.dart';
import '../../../../home/doman/repository/user_repo.dart';
import '../ringtone_picker_view.dart';
import 'about_me_view.dart';
import 'setting_item_widget.dart';
import 'terms_view.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  Person? currentUser;
  bool focused = false;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final ModeCubit modeCubit = context.read<ModeCubit>();
    final LanguageCubit languageCubit = context.read<LanguageCubit>();
    return BlocBuilder<ModeCubit, AppThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == AppThemeMode.dark;

        return Column(
          children: [
            UserAccountImage(
              currentUser: currentUser,
              radius: size.height * .05,
            ),

            SizedBox(height: size.height * .04),

            /// 👤 Name & birthday
            ListTile(
              leading: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.edit, color: AppColors.blue),
                onPressed: () {
                  setState(() => focused = true);
                },
              ),
              title: Center(
                child: TextField(
                  autofocus: focused,
                  canRequestFocus: focused,
                  selectAllOnFocus: focused,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        '${currentUser?.name ?? 'No User'}   ${currentUser?.birthDayDate ?? ''}',
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const Divider(indent: 20, endIndent: 20),

            /// 🌙 Theme toggle (CLEAN)
            SettingItemWidget(
              icon: Switch(
                value: isDarkMode,
                activeThumbColor: AppColors.teal,
                onChanged: (_) {
                  modeCubit.toggleMode();
                },
              ),
              child: Text(
                S.of(context).theme,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            SettingItemWidget(
              child: Row(
                children: [
                  Text(
                    S.of(context).language,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Spacer(),

                  TextButton(
                    onPressed: () {
                      languageCubit.changeLanguage('ar');
                    },
                    child: Text(S.of(context).Arabic),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      languageCubit.changeLanguage('en');
                    },
                    child: Text(S.of(context).English),
                  ),
                  Spacer(),
                ],
              ),
            ),

            /// 🔔 Notification sound
            SettingItemWidget(
              onTap: () async {
                await LocalNotification(
                  navigatorKey: navigatorKey,
                ).showAlarmNotification();
                Context(context).goTo(const RingtonePickerView());
              },
              icon: Icon(Icons.queue_music, color: AppColors.blue),
              child: Text(
                S.of(context).NotificationSound,
                style: const TextStyle(color: Colors.black),
              ),
            ),

            const Divider(indent: 20, endIndent: 20),

            /// 📜 Terms
            SettingItemWidget(
              onTap: () => Context(context).goTo(TermView()),
              icon: Icon(Icons.list_alt_rounded, color: AppColors.blue),
              child: Text(
                S.of(context).TermsAndPolicySection,
                style: const TextStyle(color: Colors.black),
              ),
            ),

            /// ℹ️ About
            SettingItemWidget(
              onTap: () => Context(context).goTo(AboutMeView()),
              icon: Icon(Icons.info_outline_rounded, color: AppColors.blue),
              child: Text(
                S.of(context).AboutSection,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getCurrentUser() async {
    final user = await getIt<UserRepository>().getCurrentUser();
    setState(() => currentUser = user);
  }
}
