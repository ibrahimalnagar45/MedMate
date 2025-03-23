import 'package:flutter/material.dart';
 import 'package:midmate/features/home/presentation/views/home_view.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_heart_icon.dart';
import 'package:midmate/utils/extension_fun.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/models/user_model.dart';
import '../../../../../utils/text_styles.dart';
import 'age_drop_down_menu.dart';
import 'cusotm_label.dart';
import 'custom_text_form_feild.dart';

class UserDataViewBody extends StatefulWidget {
  const UserDataViewBody({super.key});

  @override
  State<UserDataViewBody> createState() => _UserDataViewBodyState();
}

class _UserDataViewBodyState extends State<UserDataViewBody> {
  String? userName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // log(UserModel.instance.toString());
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: SizedBox(
          height: Context(context).height(),
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset('assets/images/image 1.svg',),
              // UpperImage(),
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            SizedBox(height: Context(context).height() * .07),
                            //  custom heart circle avatar
                            CustomHeartIcon(),
                            SizedBox(height: 10),
                            const Text(
                              ' ممرضك الخاص بك ',
                              style: TextStyles.primaryBoldBlackTextStyle,
                            ),
                            SizedBox(height: 10),
                            const Text(
                              'متنساش ميعاد دواءك تاني ',
                              style: TextStyles.regGreyTextStyle,
                            ),

                            CustomLabel(title: 'الاسم'),
                            CustomTextFormFeild(
                              // hintText: 'ادخل الاسم',
                              validator: (vlaue) {
                                if (vlaue!.isEmpty || vlaue.trim().isEmpty) {
                                  return 'يجب ان تدخل اسمك';
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
                            CustomLabel(title: 'العمر'),

                            AgeDropDownMenu(
                              onSelected: (value) {
                                if (_formKey.currentState!.validate()) {
                                  UserModel.instance.editUser(
                                    Person(age: value, name: userName),
                                  );

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HomeView(),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Image.asset(ImageController.splashImage),
            ],
          ),
        ),
      ),
    );
  }
}

 
class UpperImage extends StatelessWidget {
  const UpperImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 11 / 12,
      child: Image.asset('assets/images/image 1.png', fit: BoxFit.cover),
    );
  }
}
