import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:midmate/core/services/local_notification.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/details_view.dart';
import 'package:midmate/features/home/presentation/views/widgets/custom_med_type_icon.dart';
import 'package:midmate/main.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/image_controller.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/text_styles.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CustomMedListTile extends StatelessWidget {
  const CustomMedListTile({super.key, required this.medModel});
  final MedModel medModel;
  @override
  Widget build(BuildContext context) {
    if (medModel.getNextTime()!.isAfter(DateTime.now())) {
      log("next time is after now");
      medModel.setNextTime();
    }
    return Dismissible(
      secondaryBackground: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.delete, color: AppColors.red),
      ),
      background: Container(
        // color: AppColors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: AppColors.red),
      ),
      key: Key(medModel.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        BlocProvider.of<MedsCubit>(context).deleteAMed(medModel.id!);
        BlocProvider.of<MedsCubit>(context).getAllMed();
        LocalNotification(
          navigatorKey: navigatorKey,
        ).cancleNotification(id: medModel.id!);
      },
      child: GestureDetector(
        onTap: () {
          context.goTo(DetailsView(med: medModel));
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
              _medIcon(medModel.type!),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '                   AppLocalizations.of(context)!.medName(medModel.name!),',
                    style: TextStyles.regWhtieTextStyle,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: medModel.dose!.toInt().toString(),
                          style: TextStyles.regGreyTextStyle,
                        ),
                        TextSpan(text: ' '),
                        TextSpan(
                          text:
                              medModel.getArabicMedType() == 'مسحوق' ||
                                      medModel.getArabicMedType() == 'شراب' ||
                                      medModel.getArabicMedType() == 'بخاخ' ||
                                      medModel.getArabicMedType() == 'كريم'
                                  ? "ملي"
                                  : medModel.getArabicMedType(),
                          style: TextStyles.regGreyTextStyle,
                        ),
                        TextSpan(
                          text:
                              medModel.frequency!.toInt() == 24
                                  ? " كل يوم "
                                  : " كل ${medModel.frequency!} ساعات",
                          style: TextStyles.regGreyTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                medModel.startDate == null
                    ? ''
                    : " الموعد القادم  ${medModel.getFormattedNextTime()}",
                style: TextStyles.regWhtieTextStyle,
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
