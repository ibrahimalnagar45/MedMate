import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getIt<SharedPreferences>()
              .getString(SharedPrefrenceDb.username)
              .toString(),
        ),
      ),
      backgroundColor: AppColors.grey,
      body: BlocProvider(
        create: (context) => MedsCubit()..getAllMed(),
        child: HomeViewBody(),
      ),
    );
  }
}
