import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';

import 'widgets/add_new_user_view_body.dart';

class AddNewUserView extends StatelessWidget {
  const AddNewUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddNewUserViewBody(),
    );
  }
}
