import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/features/home/presentation/views/home_view.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_button.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_heart_icon.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/image_controller.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/services/shared_prefrence_service.dart';
import '../../../../../utils/text_styles.dart';
import 'cusotm_label.dart';
import 'custom_text_form_feild.dart';

class UserDataViewBody extends StatefulWidget {
  const UserDataViewBody({super.key});

  @override
  State<UserDataViewBody> createState() => _UserDataViewBodyState();
}

class _UserDataViewBodyState extends State<UserDataViewBody> {
  String? userName, dateOfBirth;
  DateTime? tempDateOfBirth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final int _userIds = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    // log(UserModel.instance.toString());
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: SizedBox(
          height: Context(context).height(),
          child: Stack(
            children: [
              // SvgPicture.asset('assets/images/image 1.svg'),
              UpperImage(),
              Positioned(
                top: size.height * .2,
                bottom: 0,
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
                            Text(
                              S.of(context).yourPrivateNurse,
                              style: TextStyles.primaryBoldBlackTextStyle,
                            ),
                            SizedBox(height: 10),
                            Text(
                              S.of(context).dontForgetMedicine,
                              style: TextStyles.regGreyTextStyle,
                            ),

                            CustomLabel(
                              title: S.of(context).userName,
                              isImporant: false,
                            ),
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
                            CustomLabel(
                              title: S.of(context).birthOfDate,
                              isImporant: false,
                            ),
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
                                  initialEntryMode:
                                      DatePickerEntryMode.inputOnly,

                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                );
                                if (date != null) {
                                  tempDateOfBirth = date;
                                  dateOfBirth =
                                      DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(date).toString();
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

                            CustomButton(
                              onPressed: () {
                                if (userName != null && dateOfBirth != null) {
                                  if (_formKey.currentState!.validate()) {
                                    saveUser(context);

                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => HomeView(),
                                      ),
                                    );
                                  } else {
                                    log(
                                      userName.toString() +
                                          dateOfBirth.toString(),
                                    );
                                    log('user name or date of birth is null');
                                  }
                                } else {
                                  log('user name or date of birth is null');

                                  log(
                                    userName.toString() +
                                        dateOfBirth.toString(),
                                  );
                                }
                              },
                              bgColor: AppColors.white,
                              title: S.current.Add,
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

  void saveUser(BuildContext thisContext) async {
    log('save user is called');
    log('user name and date of birth');
    log(userName!);
    log(dateOfBirth!);
    getIt<SharedPreferences>().setString(SharedPrefrenceDb.username, userName!);
    getIt<SharedPreferences>().setString(
      SharedPrefrenceDb.userAge,
      dateOfBirth!,
    );
    getIt<SharedPreferences>().setString(
      SharedPrefrenceDb.userId,
      _userIds.toString(),
    );

    final Person currentUser = Person(
      age: dateOfBirth,
      name: userName,
      isCurrentUser: 1,
    );
    await getIt<UserCubit>().addNewUser(currentUser);
    Crud.instance.insertUser(currentUser);
  }
}

class UpperImage extends StatelessWidget {
  const UpperImage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * .3,
      child: AspectRatio(
        aspectRatio: 2,
        child: Image.asset(
          ImageController.userDateViewImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
