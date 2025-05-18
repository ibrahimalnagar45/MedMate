import 'package:flutter/material.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../utils/extension_fun.dart';
import '../../../../../utils/models/user_model.dart';
import '../../../../../utils/service_locator.dart';
import '../../../../user_data/presentation/views/add_new_user_view.dart';

AppBar buildAppBar(String screenName, BuildContext context) {
  final GlobalKey buttonKey = GlobalKey();
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
        key: buttonKey,
        onPressed: () async {
          List<Person> users = await Crud.instance.getAllusers();

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
          final selcted = await showMenu(
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
                          value: value.id.toString(),
                          child: TextButton(
                            onPressed: () {
                              currentUser = value;
                            },
                            child: Text(value.name!),
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
          );

          if (selcted != null) {
            context.pop();
          }

          // showMenu(
          //   context:  context,
          //   dropdownMenuEntries:
          //       users.isNotEmpty
          //           ? users
          //               .asMap()
          //               .map(
          //                 (key, value) => MapEntry(
          //                   key,
          //                   DropdownMenuEntry(
          //                     value: value.id.toString(),
          //                     label: value.name!,
          //                   ),
          //                 ),
          //               )
          //               .values
          //               .toList()
          //           : [
          //             DropdownMenuEntry(
          //               value: "No User",
          //               label: 'No User',
          //               style: ButtonStyle(
          //                 backgroundColor: WidgetStatePropertyAll(
          //                   AppColors.red,
          //                 ),
          //               ),
          //             ),
          //           ],
          // );

          // DropdownMenu(
          //   context: context,
          //   items:
          // users
          //     .asMap()
          //     .map(
          //       (key, value) => MapEntry(
          //         key,
          //         PopupMenuItem(child: Text("value.name!")),
          //       ),
          //     )
          //     .values
          //     .toList(),
          // );
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
            currentUser.name![0].toUpperCase(),
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    ),
    actionsPadding: const EdgeInsets.only(right: 10),
  );
}
