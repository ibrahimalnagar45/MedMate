import 'package:flutter/material.dart';
 import 'package:intl/intl.dart';
  import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_button.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
import '../../../../../core/managers/user_cubit/user_cubit.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/text_styles.dart';
import 'cusotm_label.dart';
import 'custom_text_form_feild.dart';

class AddNewUserViewBody extends StatefulWidget {
  const AddNewUserViewBody({super.key});

  @override
  State<AddNewUserViewBody> createState() => _AddNewUserViewBodyState();
}

class _AddNewUserViewBodyState extends State<AddNewUserViewBody> {
  String? userName, dateOfBirth;
  DateTime? tempDateOfBirth;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // return Container();

    return Form(
      key: _formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.vertical(
            // top: Radius.circular(50),
            // bottom: Radius.circular(50),
          ),
        ),

        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: Context(context).height() * .07),
              SizedBox(height: 10),
              Text(
                S.of(context).yourPrivateNurse,
                style: TextStyles.primaryBoldBlackTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                S.of(context).dontForgetMedicine,
                style: TextStyles.regGreyTextStyle,
              ),

              CustomLabel(title: S.of(context).userName),
              CustomTextFormFeild(
                validator: (vlaue) {
                  if (vlaue!.isEmpty || vlaue.trim().isEmpty) {
                    return S.of(context).nameRequired;
                  }
                  return null;
                },
                onSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    userName = value;
                    setState(() {});
                  }
                },
              ),
              SizedBox(height: 15),
              CustomLabel(title: S.of(context).userAge),

              GestureDetector(
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDatePickerMode: DatePickerMode.year,

                    locale: Locale('en'),
                    initialDate:
                        tempDateOfBirth == null
                            ? DateTime.now()
                            : tempDateOfBirth!,
                    initialEntryMode: DatePickerEntryMode.inputOnly,

                    firstDate: DateTime(2000),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (date != null) {
                    tempDateOfBirth = date;
                    dateOfBirth =
                        DateFormat('yyyy-MM-dd').format(date).toString();
                    setState(() {});
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(right: 10, left: 10),

                  height: 60,
                  width: context.width(),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        dateOfBirth == null
                            ? S.of(context).userAge
                            : dateOfBirth!,
                        style: TextStyles.hintTextStyle,
                      ),
                    ],
                  ),
                ),
              ),

              // AgeDropDownMenu(
              //   onSelected: (value) {
              //     age = value;
              //     setState(() {});
              //   },
              // ),
              SizedBox(height: 80),

              CustomButton(
                bgColor: AppColors.grey,
                title: S.of(context).Add,
                strColor: AppColors.blue,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    getIt<UserCubit>().addNewUser(
                      Person(
                        name: userName!,
                        birthDayDate: dateOfBirth!,
                        isCurrentUser: 1,
                      ),
                    );

                    Future.delayed(Duration(seconds: 1), () {
                          getIt<UserCubit>().setCurrentUser(
                            Person(name: userName!, birthDayDate: dateOfBirth!),
                          );
                        })
                        .then((_) {
                          getIt<MedsCubit>().getAllMeds();
                        })
                        .then((_) {
                          getIt<UserCubit>().getCurrentUser();
                        });

                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
