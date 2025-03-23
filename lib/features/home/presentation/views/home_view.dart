import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';

import '../../../../utils/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: BlocProvider(
        create: (context) => MedsCubit()..getAllMed(),
        child: HomeViewBody(),
      ),
    );
  }
}
