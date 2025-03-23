import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import 'widgets/user_data_view_body.dart';

class UserDataView extends StatelessWidget {
  const UserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color: AppColors.blue,
      backgroundColor: AppColors.blue,
      body: SafeArea(child: UserDataViewBody()),
    );
  }
}
