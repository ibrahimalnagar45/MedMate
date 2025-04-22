import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:midmate/core/services/local_notification.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/cusotm_label.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_button.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_text_form_feild.dart';
import 'package:midmate/main.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/med_model.dart';
import '../../manager/cubit/meds_cubit.dart';
import 'custom_drop_down_menu.dart';

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
  MedModel medModel = MedModel.newMed();
  String? errorMessage;
  late List<DropdownMenuEntry> doseEntries;

  @override
  void initState() {
    doseEntries = [];
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
              CustomLabel(title: 'اسم الدواء', color: AppColors.blue),
              CustomTextFormFeild(
                hintText: 'مثال: الميتفورمين',
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'يرجى ادخال اسم الدواء';
                //   }
                // },
                onSubmitted: (vale) {
                  setState(() {
                    medModel.name = vale;
                  });
                },
              ),

              CustomLabel(title: 'نوع الدواء', color: AppColors.blue),
              CustomDropDownMenu(
                // medModel: medModel,
                hintText: ' مثال: اقراص ,دواء, حقن',
                entries: List.generate(MedType.values.length, (index) {
                  return DropdownMenuEntry(
                    label: getArabicMedType(MedType.values[index]),
                    value: MedType.values[index],
                  );
                }),
                onSelected: (value) {
                  log(value.toString());
                  setState(() {
                    medModel.type = value;
                    doseEntries = getMedDoseEntries(value);
                  });
                },
              ),

              CustomLabel(title: 'الجرعة', color: AppColors.blue),
              CustomDropDownMenu(
                hintText: 'مثال: 1 قرص, 30 ملي',
                entries: doseEntries,
                onSelected: (value) {
                  log(value.runtimeType.toString());
                  log(value.toString());
                  setState(() {
                    medModel.dose = double.tryParse(value.toString());
                  });
                },
              ),
              CustomLabel(title: ' المده', color: AppColors.blue),
              CustomDropDownMenu(
                entries: getDurationEntries(),
                hintText: 'مثال: كل 6, 8, 12 ساعات, كل يوم',
                onSelected: (value) {
                  setState(() {
                    medModel.frequency = value;
                  });
                },
              ),

              CustomLabel(title: 'تاريخ البدء', color: AppColors.blue),
              CustomDropDownMenu(
                entries: getStartDateEntries(),
                hintText: 'مثال: الان, 6, 8, 12  بعد ساعة',
                onSelected: (value) {
                  medModel.startDate = DateTime(0, 0, 0, value, 0, 1, 0, 0);
                },
              ),
              CustomLabel(
                title: ' وصف او ملاحظات',
                color: AppColors.blue,
                isImporant: false,
              ),

              CustomTextFormFeild(hintText: 'مثال: يرج قبل الاستخدام'),
              SizedBox(height: 20),
              errorMessage != null
                  ? Text(errorMessage!, style: TextStyle(color: AppColors.red))
                  : const SizedBox(),

              SizedBox(
                width: 150,
                child: CustomButton(
                  bgColor: AppColors.blue,
                  title: 'اضافة',
                  strColor: AppColors.white,
                  onPressed: () {
                    medModel.getFormattedNextTime();
                    if (widget._formKey.currentState!.validate()) {
                      if (medModel.type == null ||
                          medModel.name == null ||
                          medModel.dose == null ||
                          medModel.startDate == null ||
                          medModel.frequency == null) {
                        errorMessage = 'يرجى تعبئة جميع الحقول المطلوبة';
                        medModel.description = 'non';
                        setState(() {});
                        log('empty fields');
                        return;
                      }

                      log(medModel.toString());
                      LocalNotification(
                        navigatorKey: navigatorKey,
                      ).showScheduledRepeatedNotification(
                        title:
                            'this is the time to take ur medicine ${medModel.name}',
                        body:
                            'this is the time to take ur medicine ${medModel.name}',
                        date: medModel.nextTime!,

                        // id: medModel.id,
                      );

                      BlocProvider.of<MedsCubit>(context).insert(medModel);
                      context.pop();
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
      DropdownMenuEntry(label: 'الان', value: 0),
      DropdownMenuEntry(label: 'بعد 6 ساعات', value: 6),
      DropdownMenuEntry(label: 'بعد 8 ساعات', value: 8),
      DropdownMenuEntry(label: 'بعد 12 ساعات', value: 12),
      DropdownMenuEntry(label: 'بعد يوم', value: 24),
    ];
  }
}

getDurationEntries() {
  return [
    DropdownMenuEntry(value: 6, label: 'كل 6 ساعات'),
    DropdownMenuEntry(value: 8, label: 'كل 8 ساعات'),
    DropdownMenuEntry(value: 12, label: 'كل 12 ساعات'),
    DropdownMenuEntry(value: 24, label: 'كل يوم'),
  ];
}

getMedDoseEntries(MedType? medType) {
  if (medType == MedType.pill) {
    return List.generate(4, (index) {
      return DropdownMenuEntry(label: '${index + 1} قرص', value: index + 1);
    });
  } else if (medType == MedType.syrup || medType == MedType.powder) {
    return List.generate(4, (index) {
      return DropdownMenuEntry(
        label: '${(index + 1) * 10} ملي',
        value: index + 1 * 10,
      );
    });
  } else if (medType == MedType.drop) {
    return List.generate(4, (index) {
      return DropdownMenuEntry(label: '${index + 1} قطرة', value: index + 1);
    });
  } else if (medType == MedType.cream) {
    return List.generate(4, (index) {
      return DropdownMenuEntry(label: '${index + 1} ملي', value: index + 1);
    });
  } else if (medType == MedType.injection) {
    return List.generate(4, (index) {
      return DropdownMenuEntry(label: '${index + 1} حقنة', value: index + 1);
    });
  } else if (medType == MedType.inhaler) {
    return List.generate(4, (index) {
      return DropdownMenuEntry(label: '${index + 1} بخه', value: {index + 1});
    });
  } else {
    return [];
  }
}
