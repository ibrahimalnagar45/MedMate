import 'package:flutter/material.dart';
import 'widgets/auth_view_body.dart';

class UserDataView extends StatelessWidget {
  const UserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.grey,
      body: SafeArea(child: UserDataViewBody()),
    );
  }
}
