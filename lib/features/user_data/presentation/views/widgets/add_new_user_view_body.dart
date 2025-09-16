import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/functions/get_unique_id.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_button.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';

import '../../../../../core/managers/user_cubit/user_cubit.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/text_styles.dart';
import 'age_drop_down_menu.dart';
import 'cusotm_label.dart';
import 'custom_text_form_feild.dart';

class AddNewUserViewBody extends StatefulWidget {
  const AddNewUserViewBody({super.key});

  @override
  State<AddNewUserViewBody> createState() => _AddNewUserViewBodyState();
}

class _AddNewUserViewBodyState extends State<AddNewUserViewBody> {
  String? userName;
  String? age;
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

              AgeDropDownMenu(
                onSelected: (value) {
                  age = value;
                  setState(() {});
                },
              ),
              SizedBox(height: 80),

              CustomButton(
                bgColor: AppColors.grey,
                title: S.of(context).Add,
                strColor: AppColors.blue,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    getIt<UserCubit>().addNewUser(
                      Person(name: userName!, age: age!, isCurrentUser: 1),
                    );

                    Future.delayed(Duration(seconds: 1), () {
                          getIt<UserCubit>().setCurrentUser(
                            Person(name: userName!, age: age!),
                          );
                        })
                        .then((_) {
                          getIt<MedsCubit>().getUserAllMeds();
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
