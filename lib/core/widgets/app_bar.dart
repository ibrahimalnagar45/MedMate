import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/features/chart/presentaion/manager/cubit/logs_cubit.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/settings/presentaion/views/settings_view.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/utils/text_styles.dart';
import '../../utils/extension_fun.dart';
import '../../utils/models/user_model.dart';
import '../../features/user_data/presentation/views/add_new_user_view.dart';
import 'user_account_image.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.screenName,
    required this.context,
    this.autoleading = false,
  });
  final String screenName;
  final BuildContext context;
  final bool? autoleading;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final UserCubit userCubit = getIt<UserCubit>();
  final GlobalKey buttonKey = GlobalKey();
  Person? currentUser;
  // late MedsCubit medCubit;
  List<Person> users = [];
  @override
  void initState() {
    _loadData();
    // medCubit = context.read<MedsCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is GetUserSuccess) {
          setState(() {
            currentUser = state.user;
          });
        } else if (state is SetUserSuccess) {
          setState(() {
            currentUser = state.user;
          });
        } else if (state is AddNewUserSuccess) {
          log('add new user success is fired');
          await userCubit.setCurrentUser(state.user);

          await userCubit.getAllUsers().then((value) {
            users = value;
            getIt<MedsCubit>().getAllMeds();
          });

          setState(() {});
        }
      },
      child: AppBar(
        // backgroundColor: AppColors.grey,
        // backgroundColor: Colors.transparent,
        title: Text(
          S.current.appBarTitle(widget.screenName),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: widget.autoleading!,
        actionsIconTheme: IconThemeData(color: AppColors.blue),
        iconTheme: IconThemeData(color: AppColors.blue),
        actions:
            widget.screenName == 'Home' || widget.screenName == 'الرئيسية'
                ? [
                  IconButton(
                    onPressed: () {
                      context.goTo(AddNewUserView());
                    },
                    icon: Icon(Icons.add),
                  ),
                  Text(
                    currentUser == null ? '' : currentUser!.name!,
                    style: TextStyles.hintTextStyle.copyWith(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  IconButton(
                    key: buttonKey,
                    onPressed: () async {
                      RelativeRect position = getTheButtomPostion(context);

                      await showMenu<Person>(
                        context: context,
                        position: position,
                        items:
                            users
                                .asMap()
                                .map(
                                  (key, value) => MapEntry(
                                    key,
                                    PopupMenuItem(
                                      value: value,
                                      child: TextButton(
                                        onPressed: () async {
                                          await userCubit.setCurrentUser(value);

                                          await getIt<MedsCubit>().getAllMeds();
                                          Context(context).pop();
                                        },
                                        child: Text(value.name!),
                                      ),
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                      );
                    },
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ]
                : [],

        leading:
            widget.autoleading == true
                ? null
                : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () async {
                      var logs = await getIt<LogsCubit>().getTodayLogs();
                      log(logs.toString());

                      Context(context).goTo(SettingsView());
                    },
                    child: UserAccountImage(currentUser: currentUser),
                  ),
                ),
        actionsPadding: const EdgeInsets.only(right: 10),
      ),
    );
  }

  void _loadData() async {
    currentUser = await userCubit.getCurrentUser();
    users = await userCubit.getAllUsers();
  }

  RelativeRect getTheButtomPostion(BuildContext context) {
    final RenderBox button =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        // ignore: use_build_context_synchronously
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }
}
