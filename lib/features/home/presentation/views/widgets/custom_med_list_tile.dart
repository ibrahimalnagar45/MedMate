import 'package:flutter/material.dart';
import 'package:midmate/core/services/local_notification.dart';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/details_view.dart';
import 'package:midmate/features/home/presentation/views/widgets/custom_med_type_icon.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/main.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/image_controller.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/utils/text_styles.dart';
import 'package:intl/intl.dart';

import '../../../../../core/functions/check_med_next_time.dart';
import 'med_info.dart';

class CustomMedListTile extends StatefulWidget {
  const CustomMedListTile({super.key, required this.medModel});
  final MedModel medModel;

  @override
  State<CustomMedListTile> createState() => _CustomMedListTileState();
}

class _CustomMedListTileState extends State<CustomMedListTile> {
  // Person currentUser =Person();
  final medsCubit = getIt<MedsCubit>();
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
        medsCubit.deleteAMed(widget.medModel.id!, MedsTable.tableName);
        medsCubit.getUserAllMeds();
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

              MedInfo(medModel: widget.medModel),

              Expanded(
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
}

_medIcon(MedType medType) {
  switch (medType) {
    case MedType.pill:
      return CustomMedTypeIcon(icon: ImageController.pill);
    case MedType.injection:
      return CustomMedTypeIcon(icon: ImageController.injection);
    case MedType.inhaler:
      return CustomMedTypeIcon(icon: ImageController.inhaler);
    case MedType.cream:
      return CustomMedTypeIcon(icon: ImageController.cream);
    case MedType.syrup:
      return CustomMedTypeIcon(icon: ImageController.syrup);
    case MedType.powder:
      return CustomMedTypeIcon(icon: ImageController.powder);
    case MedType.drop:
      return CustomMedTypeIcon(icon: ImageController.drop);
    default:
      return const SizedBox.shrink();
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
