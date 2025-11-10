import 'package:flutter/material.dart';
import 'package:midmate/utils/models/user_model.dart';

import '../../utils/app_colors.dart';

class UserAccountImage extends StatelessWidget {
  const UserAccountImage({super.key, required this.currentUser});

  final Person? currentUser;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.blue,
      child: Text(
        currentUser == null ? '' : currentUser!.name![0],
        style: TextStyle(color: AppColors.white),
      ),
    );
  }
}
