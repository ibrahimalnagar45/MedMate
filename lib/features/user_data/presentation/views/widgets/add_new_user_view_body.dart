import 'package:flutter/material.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/user_model.dart';

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
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
              bottom: Radius.circular(50),
            ),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
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
                    if (_formKey.currentState!.validate()) {
                      Crud.instance.insertUser(
                        Person(name: userName!, age: age!),
                      );

                      context.pop();
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => HomeView(),
                      //   ),
                      // );
                    }
                  },
                ),
                // SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}
