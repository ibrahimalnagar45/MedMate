import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/services/functions/get_localized_med_type.dart';
import 'package:midmate/core/services/local_notification.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/details_view.dart';
import 'package:midmate/features/home/presentation/views/widgets/custom_med_type_icon.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/main.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/image_controller.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/text_styles.dart';
import 'package:intl/intl.dart';

import '../../../../../core/services/functions/check_med_next_time.dart';

class CustomMedListTile extends StatefulWidget {
  const CustomMedListTile({super.key, required this.medModel});
  final MedModel medModel;

  @override
  State<CustomMedListTile> createState() => _CustomMedListTileState();
}

class _CustomMedListTileState extends State<CustomMedListTile> {
  @override
  void initState() {
    checkMedNextTime(widget.medModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      secondaryBackground: Container(
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.delete, color: AppColors.red),
      ),
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: AppColors.red),
      ),
      key: Key(widget.medModel.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        BlocProvider.of<MedsCubit>(context).deleteAMed(widget.medModel.id!);
        BlocProvider.of<MedsCubit>(context).getAllMed();
        LocalNotification(
          navigatorKey: navigatorKey,
        ).cancleNotification(id: widget.medModel.id!);
      },
      child: GestureDetector(
        onTap: () {
          context.goTo(DetailsView(med: widget.medModel));
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              _medIcon(widget.medModel.type!),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).medName(widget.medModel.name!),
                    // S.of(context).ttt,
                    style: TextStyles.regWhtieTextStyle,
                  ),

                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.medModel.dose!.toInt().toString(),
                          style: TextStyles.regGreyTextStyle,
                        ),
                        TextSpan(text: ' '),
                        TextSpan(
                          text:
                              getLocalizedMedType(
                                            widget.medModel.type!,
                                            context,
                                          ) ==
                                          S.of(context).powder ||
                                      getLocalizedMedType(
                                            widget.medModel.type!,
                                            context,
                                          ) ==
                                          S.of(context).syrup ||
                                      getLocalizedMedType(
                                            widget.medModel.type!,
                                            context,
                                          ) ==
                                          S.of(context).inhaler ||
                                      getLocalizedMedType(
                                            widget.medModel.type!,
                                            context,
                                          ) ==
                                          S.of(context).cream
                                  ? S.of(context).ml
                                  : S
                                      .of(context)
                                      .medType(
                                        isArabic()
                                            ? getLocalizedMedType(
                                              widget.medModel.type!,
                                              context,
                                            )
                                            : S
                                                .of(context)
                                                .medType(widget.medModel.type!)
                                                .toString()
                                                .substring(8),
                                      ),

                          style: TextStyles.regGreyTextStyle,
                        ),
                        TextSpan(text: ' '),
                        TextSpan(
                          text:
                              widget.medModel.frequency!.toInt() == 24
                                  ? S.of(context).everyDay
                                  : S
                                      .of(context)
                                      .everyNumHour(widget.medModel.frequency!),
                          style: TextStyles.regGreyTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Spacer(),
              Expanded(
                // fit: FlexFit.tight,
                child: Text(
                  widget.medModel.startDate == null
                      ? ''
                      : " ${widget.medModel.getFormattedNextTime()}",
                  style: TextStyles.regWhtieTextStyle,
                  textAlign: isArabic() ? TextAlign.left : TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _medIcon(MedType medType) {
    if (medType == MedType.pill) {
      return CustomMedTypeIcon(icon: ImageController.pill);
    } else if (medType == MedType.injection) {
      return CustomMedTypeIcon(icon: ImageController.injection);
    } else if (medType == MedType.inhaler) {
      return CustomMedTypeIcon(icon: ImageController.inhaler);
    } else if (medType == MedType.cream) {
      return CustomMedTypeIcon(icon: ImageController.cream);
    } else if (medType == MedType.syrup) {
      return CustomMedTypeIcon(icon: ImageController.syrup);
    } else if (medType == MedType.powder) {
      return CustomMedTypeIcon(icon: ImageController.powder);
    } else if (medType == MedType.drop) {
      return CustomMedTypeIcon(icon: ImageController.drop);
    }
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
