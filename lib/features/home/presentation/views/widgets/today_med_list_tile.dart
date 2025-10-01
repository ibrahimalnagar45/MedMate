// import 'package:flutter/material.dart';
// import 'package:midmate/core/functions/get_localized_med_type.dart';
// import 'package:midmate/features/home/presentation/views/details_view.dart';
// import 'package:midmate/features/home/presentation/views/widgets/custom_med_type_icon.dart';
// import 'package:midmate/generated/l10n.dart';
// import 'package:midmate/utils/app_colors.dart';
// import 'package:midmate/utils/extension_fun.dart';
// import 'package:midmate/utils/image_controller.dart';
// import 'package:midmate/utils/models/med_model.dart';
// import 'package:midmate/utils/text_styles.dart';
// import 'package:intl/intl.dart';

// import '../../../../../core/functions/check_med_next_time.dart';

// class TodayMedListTile extends StatefulWidget {
//   const TodayMedListTile({super.key, required this.medModel});
//   final MedModel medModel;

//   @override
//   State<TodayMedListTile> createState() => TodayMedListTileState();
// }

// class TodayMedListTileState extends State<TodayMedListTile> {
//   // Person currentUser =Person();

//   @override
//   void initState() {
//     checkMedNextTime(widget.medModel);
//     // currentUser = getIt<UserCubit>().getCurrentUser();
//     super.initState();
//   }

//   bool checked = false;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         context.goTo(DetailsView(med: widget.medModel));
//       },
//       child: CheckboxListTile(
//         value: checked,
//         onChanged: (value) {
//           setState(() {
//             checked = value!;
//           });
//         },
//         contentPadding: const EdgeInsets.all(0),

//         checkboxShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//         title: Container(
//           height: 60,
//           decoration: BoxDecoration(
//             color: AppColors.blue,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           margin: const EdgeInsets.only(bottom: 10),
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Row(
//             children: [
//               _medIcon(widget.medModel.type!),
//               SizedBox(width: 10),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     S.of(context).medName(widget.medModel.name!),
//                     // S.of(context).ttt,
//                     style: TextStyles.regWhtieTextStyle,
//                   ),

//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: widget.medModel.dose!.toInt().toString(),
//                           style: TextStyles.regGreyTextStyle,
//                         ),
//                         TextSpan(text: ' '),
//                         TextSpan(
//                           text:
//                               getLocalizedMedType(
//                                             widget.medModel.type!,
//                                             context,
//                                           ) ==
//                                           S.of(context).powder ||
//                                       getLocalizedMedType(
//                                             widget.medModel.type!,
//                                             context,
//                                           ) ==
//                                           S.of(context).syrup ||
//                                       getLocalizedMedType(
//                                             widget.medModel.type!,
//                                             context,
//                                           ) ==
//                                           S.of(context).inhaler ||
//                                       getLocalizedMedType(
//                                             widget.medModel.type!,
//                                             context,
//                                           ) ==
//                                           S.of(context).cream
//                                   ? S.of(context).ml
//                                   : S
//                                       .of(context)
//                                       .medType(
//                                         isArabic()
//                                             ? getLocalizedMedType(
//                                               widget.medModel.type!,
//                                               context,
//                                             )
//                                             : S
//                                                 .of(context)
//                                                 .medType(widget.medModel.type!)
//                                                 .toString()
//                                                 .substring(8),
//                                       ),

//                           style: TextStyles.regGreyTextStyle,
//                         ),
//                         TextSpan(text: ' '),
//                         TextSpan(
//                           text:
//                               widget.medModel.frequency!.toInt() == 24
//                                   ? S.of(context).everyDay
//                                   : S
//                                       .of(context)
//                                       .everyNumHour(widget.medModel.frequency!),
//                           style: TextStyles.regGreyTextStyle,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               // Spacer(),
//               Expanded(
//                 child: Text(
//                   widget.medModel.startDate == null
//                       ? ''
//                       : " ${widget.medModel.getFormattedNextTime()}",
//                   style: TextStyles.regWhtieTextStyle,
//                   textAlign: isArabic() ? TextAlign.left : TextAlign.right,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _medIcon(MedType medType) {
//     if (medType == MedType.pill) {
//       return CustomMedTypeIcon(icon: ImageController.pill);
//     } else if (medType == MedType.injection) {
//       return CustomMedTypeIcon(icon: ImageController.injection);
//     } else if (medType == MedType.inhaler) {
//       return CustomMedTypeIcon(icon: ImageController.inhaler);
//     } else if (medType == MedType.cream) {
//       return CustomMedTypeIcon(icon: ImageController.cream);
//     } else if (medType == MedType.syrup) {
//       return CustomMedTypeIcon(icon: ImageController.syrup);
//     } else if (medType == MedType.powder) {
//       return CustomMedTypeIcon(icon: ImageController.powder);
//     } else if (medType == MedType.drop) {
//       return CustomMedTypeIcon(icon: ImageController.drop);
//     }
//   }

//   bool isArabic() {
//     return Intl.getCurrentLocale() == 'ar';
//   }
// }

import 'package:flutter/material.dart';
import 'package:midmate/core/functions/get_localized_med_type.dart';
import 'package:midmate/features/home/presentation/views/details_view.dart';
import 'package:midmate/features/home/presentation/views/widgets/custom_med_type_icon.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/image_controller.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/text_styles.dart';
import 'package:intl/intl.dart';

class TodayMedListTile extends StatefulWidget {
  const TodayMedListTile({super.key, required this.medModel});
  final MedModel medModel;

  @override
  State<TodayMedListTile> createState() => _TodayMedListTileState();
}

class _TodayMedListTileState extends State<TodayMedListTile> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goTo(DetailsView(med: widget.medModel)),
      child: CheckboxListTile(
        value: checked,
        onChanged: (value) {
          setState(() => checked = value!);
          

        },
        contentPadding: EdgeInsets.zero,
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: MedTileContent(medModel: widget.medModel),
      ),
    );
  }
}

class MedTileContent extends StatelessWidget {
  final MedModel medModel;
  const MedTileContent({super.key, required this.medModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          MedIcon(medType: medModel.type!),
          const SizedBox(width: 10),
          MedInfoText(medModel: medModel),
          Expanded(
            child: Text(
              medModel.startDate == null
                  ? ''
                  : " ${medModel.getFormattedNextTime()}",
              style: TextStyles.regWhtieTextStyle,
              textAlign:
                  LocaleUtils.isArabic() ? TextAlign.left : TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class MedIcon extends StatelessWidget {
  final MedType medType;
  const MedIcon({super.key, required this.medType});

  @override
  Widget build(BuildContext context) {
    final icon = ImageControllerExtension.getIconForMedType(medType);
    return CustomMedTypeIcon(icon: icon);
  }
}

class MedInfoText extends StatelessWidget {
  final MedModel medModel;
  const MedInfoText({super.key, required this.medModel});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    final String medTypeLocalized = getLocalizedMedType(
      medModel.type!,
      context,
    );
    final bool isSpecialType = [
      s.powder,
      s.syrup,
      s.inhaler,
      s.cream,
    ].contains(medTypeLocalized);

    final String medTypeText =
        isSpecialType
            ? s.ml
            : s.medType(
              LocaleUtils.isArabic()
                  ? medTypeLocalized
                  : s.medType(medModel.type!).toString().substring(8),
            );

    final String frequencyText =
        medModel.frequency!.toInt() == 24
            ? s.everyDay
            : s.everyNumHour(medModel.frequency!);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.medName(medModel.name!), style: TextStyles.regWhtieTextStyle),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: medModel.dose!.toInt().toString(),
                style: TextStyles.regGreyTextStyle,
              ),
              const TextSpan(text: ' '),
              TextSpan(text: medTypeText, style: TextStyles.regGreyTextStyle),
              const TextSpan(text: ' '),
              TextSpan(text: frequencyText, style: TextStyles.regGreyTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class LocaleUtils {
  static bool isArabic() => Intl.getCurrentLocale() == 'ar';
}

extension ImageControllerExtension on ImageController {
  static String getIconForMedType(MedType medType) {
    switch (medType) {
      case MedType.pill:
        return ImageController.pill;
      case MedType.injection:
        return ImageController.injection;
      case MedType.inhaler:
        return ImageController.inhaler;
      case MedType.cream:
        return ImageController.cream;
      case MedType.syrup:
        return ImageController.syrup;
      case MedType.powder:
        return ImageController.powder;
      case MedType.drop:
        return ImageController.drop;
    }
  }
}
