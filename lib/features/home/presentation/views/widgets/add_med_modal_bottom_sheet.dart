import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:midmate/core/functions/get_localized_med_type.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/core/services/local_notification.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/cusotm_label.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_button.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_text_form_feild.dart';
import 'package:midmate/main.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/service_locator.dart';
import '../../../../../utils/services/shared_prefrence_service.dart';
import '../../manager/cubit/meds_cubit.dart';
import 'custom_drop_down_menu.dart';

int _notificationId = 0;

class AddMedModalBottomSheet extends StatefulWidget {
  const AddMedModalBottomSheet({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<AddMedModalBottomSheet> createState() => _AddMedModalBottomSheetState();
}

class _AddMedModalBottomSheetState extends State<AddMedModalBottomSheet> {
  // late MedModel medModel;
  String? errorMessage;
  late List<DropdownMenuEntry> doseEntries;
  String? medName;
  MedType? medType;
  double? medDose;
  int? medFrequency;
  DateTime? medStartDate;
  DateTime? medCreatedAt;
  String? description;
  late MedsCubit medsCubit;
  late Person? currentUser;
  @override
  void initState() {
    medsCubit = getIt<MedsCubit>();
    doseEntries = [];
    medCreatedAt = DateTime.now();
    Future.sync(() async {
      currentUser = await getIt<UserCubit>().getCurrentUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: widget._formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              // TextFormField(),
              CustomLabel(title: S.of(context).title, color: AppColors.blue),
              CustomTextFormFeild(
                hintText:
                    "${S.of(context).example}: ${S.of(context).medNameExample}",

                onSubmitted: (vale) {
                  setState(() {
                    medName = vale;
                  });
                },
              ),

              CustomLabel(title: S.of(context).type, color: AppColors.blue),
              CustomDropDownMenu(
                hintText:
                    '${S.of(context).example}: ${S.of(context).pill},${S.of(context).syrup}',
                entries: List.generate(MedType.values.length, (index) {
                  return DropdownMenuEntry(
                    label: getLocalizedMedType(MedType.values[index], context),
                    value: MedType.values[index],
                  );
                }),
                onSelected: (value) {
                  log(value.toString());
                  setState(() {
                    medType = value;
                    doseEntries = getMedDoseEntries(value);
                  });
                },
              ),

              CustomLabel(title: S.of(context).dose, color: AppColors.blue),
              CustomDropDownMenu(
                hintText:
                    "${S.of(context).example}: 1 ${S.of(context).pill}, 30 ${S.of(context).ml}",
                entries: doseEntries,
                onSelected: (value) {
                  log(value.runtimeType.toString());
                  log("$value");
                  setState(() {
                    medDose = double.tryParse("$value");
                  });
                },
              ),
              CustomLabel(
                title: S.of(context).frequency,
                color: AppColors.blue,
              ),
              CustomDropDownMenu(
                entries: getDurationEntries(context),
                hintText:
                    "${S.of(context).example}: ${S.of(context).every6Hours}, ${S.of(context).everyDay}",
                onSelected: (value) {
                  setState(() {
                    medFrequency = value;
                  });
                },
              ),

              CustomLabel(
                title: S.of(context).startDate,
                color: AppColors.blue,
              ),
              CustomDropDownMenu(
                entries: getStartDateEntries(),
                hintText: "${S.of(context).example}: ${S.of(context).now}",
                onSelected: (value) {
                  medStartDate = DateTime.now().add(Duration(hours: value));
                },
              ),
              CustomLabel(
                title: S.of(context).description,
                color: AppColors.blue,
                isImporant: false,
              ),

              CustomTextFormFeild(
                hintText:
                    "${S.of(context).example}: ${S.of(context).medDescriptionExample}",
                onSubmitted: (p0) => description = p0,
              ),
              SizedBox(height: 20),
              errorMessage != null
                  ? Text(errorMessage!, style: TextStyle(color: AppColors.red))
                  : const SizedBox(),

              SizedBox(
                width: 150,
                child: CustomButton(
                  bgColor: AppColors.blue,

                  title: S.of(context).AddMedicine,
                  strColor: AppColors.white,
                  onPressed: () async {
                    if (widget._formKey.currentState!.validate()) {
                      if (medType == null ||
                          medName == null ||
                          medDose == null ||
                          medStartDate == null ||
                          medFrequency == null) {
                        errorMessage = S.of(context).pleaseAddAllInfo;
                        setState(() {});
                        log('empty fields');
                        return;
                      }
                      MedModel med = MedModel(
                        name: medName,
                        description: description ?? S.current.unSpecified,
                        type: medType,
                        dose: medDose,
                        frequency: medFrequency,
                        startDate: medStartDate,
                        createdAt: medCreatedAt,
                        id: ++_notificationId,
                      );
                      log('Inserted med is :');
                      log(med.toString());

                      await medsCubit.insertMed(med, currentUser!.id!);

                      // medsCubit.getUserAllMeds();

                      await LocalNotification(
                        navigatorKey: navigatorKey,
                      ).showScheduledRepeatedNotification(
                        id: med.id!,
                        title:
                            'this is the time to take ur medicine ${getIt<SharedPreferences>().getString(SharedPrefrenceDb.username)}  ${med.name}',
                        body:
                            'this is the time to take ur medicine ${med.name}',
                        date: med.frequency,
                      );

                      Context(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getStartDateEntries() {
    return [
      DropdownMenuEntry(label: S.of(context).now, value: 0),
      DropdownMenuEntry(label: S.of(context).after6Hours, value: 6),
      DropdownMenuEntry(label: S.of(context).after8Hours, value: 8),
      DropdownMenuEntry(label: S.of(context).after12Hours, value: 12),
      DropdownMenuEntry(label: S.of(context).afterADay, value: 24),
    ];
  }

  getDurationEntries(context) {
    return [
      DropdownMenuEntry(value: 6, label: S.of(context).every6Hours),
      DropdownMenuEntry(value: 8, label: S.of(context).every8Hours),
      DropdownMenuEntry(value: 12, label: S.of(context).every12Hours),
      DropdownMenuEntry(value: 24, label: S.of(context).everyDay),
    ];
  }

  getMedDoseEntries(MedType? medType) {
    if (medType == MedType.pill) {
      return List.generate(4, (index) {
        return DropdownMenuEntry(
          label: '${index + 1} ${S.current.pill}',
          value: index + 1,
        );
      });
    } else if (medType == MedType.syrup ||
        medType == MedType.powder ||
        medType == MedType.cream) {
      return List.generate(4, (index) {
        return DropdownMenuEntry(
          label: '${(index + 1) * 10} ${S.current.ml}',
          value: index + 1 * 10,
        );
      });
    } else if (medType == MedType.drop) {
      return List.generate(4, (index) {
        return DropdownMenuEntry(
          label: '${index + 1} ${S.current.drop}',
          value: index + 1,
        );
      });
    } else if (medType == MedType.injection) {
      return List.generate(4, (index) {
        return DropdownMenuEntry(
          label: '${index + 1} ${S.current.injection}',
          value: index + 1,
        );
      });
    } else if (medType == MedType.inhaler) {
      return List.generate(4, (index) {
        return DropdownMenuEntry(
          label: '${index + 1} ${S.current.inhaler}',
          value: index + 1,
        );
      });
    } else {
      return [];
    }
  }
}
