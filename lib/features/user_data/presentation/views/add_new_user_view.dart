import 'package:flutter/material.dart'; 

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
