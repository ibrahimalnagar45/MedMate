import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/features/chart/presentaion/manager/cubit/logs_cubit.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/features/home/doman/repository/meds_repo.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/today_meds/doman/today_meds_repo.dart';
import 'package:midmate/features/today_meds/presentation/manager/cubit/today_meds_cubit.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/utils/text_styles.dart';
import '../../features/chart/doman/repository/logs_repo.dart';
import '../../utils/extension_fun.dart';
import '../../utils/models/user_model.dart';
import '../../features/user_data/presentation/views/add_new_user_view.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.screenName,
    required this.context,
  });
  final String screenName;
  final BuildContext context;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final UserCubit userCubit = getIt<UserCubit>();
  final GlobalKey buttonKey = GlobalKey();
  Person? currentUser;

  List<Person> users = [];
  @override
  void initState() {
    _loadData();

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
            getIt<MedsCubit>().getUserAllMeds();
          });

          setState(() {});
        }
      },
      child: AppBar(
        backgroundColor: AppColors.grey,
        title: Text(S.current.appBarTitle(widget.screenName)),
        centerTitle: true,

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

                                          await getIt<MedsCubit>()
                                              .getUserAllMeds();
                                          context.pop();
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
                : [
                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   icon: Icon(Icons.arrow_forward),
                  // ),
                ],

        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: GestureDetector(
            onTap: () async {
              await getIt<MedsRepository>().getAllMeds(currentUser!.id!);
              var logs = await getIt<LogsRepo>().getAllLogs(currentUser!.id!);
              log('logs ${logs}');

              // log(logs.toString());

              // log(
              //   Crud.instance
              //       .getUserTodayMeds(userId: currentUser!.id!)
              //       .toString(),
              // );
              // log('todayMeds ${TodayMedsCubit.todayMeds.toString()}');

              // log('takenMeds${TodayMedsCubit.takenMeds.toString()}');
            },
            child: CircleAvatar(
              backgroundColor: AppColors.blue,
              child: Text(
                currentUser == null ? '' : currentUser!.name![0],
                style: TextStyle(color: AppColors.white),
              ),
            ),
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
