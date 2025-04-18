import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midmate/features/home/presentation/views/widgets/custom_med_type_icon.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/image_controller.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/text_styles.dart';

class CustomMedListTile extends StatelessWidget {
  const CustomMedListTile({super.key, required this.medModel});
  final MedModel medModel;
  @override
  Widget build(BuildContext context) { 
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        
        iconColor: AppColors.blue,
        leading: _getIcon(medModel.type!),
        title: Text(
          medModel.name == null ? 'unknown' : medModel.name!,
          style: TextStyles.regWhtieTextStyle,
        ),

        trailing: Text(
          medModel.startDate == null
              ? ''
              : " الموعد القادم ${medModel.getFormattedNextTime()}",
          style: TextStyles.regWhtieTextStyle,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              medModel.dose == null ? '' : medModel.dose!.toInt().toString(),

              style: TextStyles.regWhtieTextStyle,
            ),

            Text(
              getArabicMedType(medModel.type!),
              style: TextStyles.regWhtieTextStyle,
            ),
            Text(
              medModel.frequency == null
                  ? ''
                  : "كل${medModel.frequency!} ساعات",
              style: TextStyles.regWhtieTextStyle,
            ),

            // dose   next_time
          ],
        ),
      ),
    );
  }

  _getIcon(MedType medType) {
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

/**
-custom sound  
 schedule notification
Full-screen intent notifications

 */