import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/cusotm_label.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_button.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_text_form_feild.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/extension_fun.dart';

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
                    medModel.donse = double.tryParse(value.toString());
                    medModel.description = 'non';
                    medModel.startDate = DateTime.now();
                  });
                },
              ),

              CustomLabel(title: ' المده', color: AppColors.blue),
              CustomDropDownMenu(
                entries: getDurationEntries(),
                hintText: 'مثال: كل 6, 8, 12 ساعات, كل يوم',
                onSelected: (value) {
                  setState(() {
                    medModel.frequency = value ;
                  });
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 150,
                child: CustomButton(
                  bgColor: AppColors.blue,
                  title: 'اضافة',
                  strColor: AppColors.white,
                  onPressed: () {
                    log(medModel.toString());
                    BlocProvider.of<MedsCubit>(context).insert(medModel);
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
        return DropdownMenuEntry(label: '${index + 1} كريم', value: index + 1);
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
}
