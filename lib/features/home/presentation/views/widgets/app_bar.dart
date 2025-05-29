import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/app_colors.dart';
import '../../../../../utils/extension_fun.dart';
import '../../../../../utils/models/user_model.dart';
import '../../../../user_data/presentation/views/add_new_user_view.dart';

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
  Person? currentUser;
  final GlobalKey buttonKey = GlobalKey();
  List<Person> users = [];
  @override
  void initState() {
    currentUser = BlocProvider.of<UserCubit>(context).getCurrentUser();

    BlocProvider.of<UserCubit>(context).getAllUsers().then((value) {
      users = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetUserSuccess) {
          currentUser = state.user;
          setState(() {});
        } else if (state is SetUserSuccess) {
          currentUser = state.user;

          setState(() {});
        }
      },
      child: AppBar(
        backgroundColor: AppColors.grey,
        title: Text(
          S.current.appBarTitle(
            widget.screenName == 'Home'
                ? S.current.home
                : S.current.description,
          ),
        ),
        centerTitle: true,
        actions: [
          Text(currentUser!.name!),
          IconButton(
            key: buttonKey,
            onPressed: () async {
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
              final selcted = await showMenu<Person>(
                // ignore: use_build_context_synchronously
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
                                onPressed: () {
                                  BlocProvider.of<UserCubit>(
                                    context,
                                  ).setCurrentUser(value);
                                  Crud.instance.getAUserMeds(id: value.id!);
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
        ],

        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: GestureDetector(
            onTap: () {
              Context(context).goTo(AddNewUserView());
            },
            child: CircleAvatar(
              backgroundColor: AppColors.blue,
              child: Text(
                currentUser!.name![0],
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.only(right: 10),
      ),
    );
  }
}

// AppBar buildAppBar({
//   required String screenName,
//   required BuildContext context,
//   // required currentUser,
//   UserCubit? userCubit,
// }) {
//   Person? currentUser = getIt<UserCubit>().getCurrentUser();
//   final GlobalKey buttonKey = GlobalKey();

//   // BlocProvider.of<UserCubit>(context).getCurrentUser();
//   return AppBar(
//     backgroundColor: AppColors.grey,
//     title: Text(
//       S.current.appBarTitle(
//         screenName == 'Home' ? S.current.home : S.current.description,
//       ),
//     ),
//     centerTitle: true,
//     actions: [
//       BlocListener<UserCubit, UserState>(
//         listener: (context, state) {
//           if (state is GetUserSuccess) {
//             currentUser = state.user;
//           }
//         },
//         child: Text(currentUser!.name!),
//       ),
//       IconButton(
//         key: buttonKey,
//         onPressed: () async {
//           List<Person> users =
//               await BlocProvider.of<UserCubit>(context).getAllUsers();

//           final RenderBox button =
//               buttonKey.currentContext!.findRenderObject() as RenderBox;
//           final RenderBox overlay =
//               // ignore: use_build_context_synchronously
//               Overlay.of(context).context.findRenderObject() as RenderBox;

//           final RelativeRect position = RelativeRect.fromRect(
//             Rect.fromPoints(
//               button.localToGlobal(Offset.zero, ancestor: overlay),
//               button.localToGlobal(
//                 button.size.bottomRight(Offset.zero),
//                 ancestor: overlay,
//               ),
//             ),
//             Offset.zero & overlay.size,
//           );
//           final selcted = await showMenu<Person>(
//             // ignore: use_build_context_synchronously
//             context: context,
//             position: position,
//             items:
//                 users
//                     .asMap()
//                     .map(
//                       (key, value) => MapEntry(
//                         key,
//                         PopupMenuItem(
//                           value: value,
//                           child: TextButton(
//                             onPressed: () {
//                               getIt<UserCubit>().setCurrentUser(value);
//                               Crud.instance.getAUserMeds(id: value.id!);
//                               getIt<UserCubit>().getCurrentUser();
//                               context.pop();
//                             },
//                             child: Text(value.name!),
//                           ),
//                         ),
//                       ),
//                     )
//                     .values
//                     .toList(),
//           );
//         },
//         icon: Icon(Icons.keyboard_arrow_down_rounded),
//       ),
//     ],

//     leading: Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: GestureDetector(
//         onTap: () {
//           Context(context).goTo(AddNewUserView());
//         },
//         child: CircleAvatar(
//           backgroundColor: AppColors.blue,
//           child: Text(
//             currentUser!.name![0],
//             style: TextStyle(color: AppColors.white),
//           ),
//         ),
//       ),
//     ),
//     actionsPadding: const EdgeInsets.only(right: 10),
//   );
// }
