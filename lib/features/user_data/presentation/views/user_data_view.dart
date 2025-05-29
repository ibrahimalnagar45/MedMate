import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/utils/service_locator.dart';
import '../../../../core/managers/user_cubit/user_cubit.dart';
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
