import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/widgets/add_med_modal_bottom_sheet.dart';
import 'package:midmate/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/cusotm_label.dart';
import 'package:midmate/features/user_data/presentation/views/widgets/custom_text_form_feild.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedsCubit()..getAllMed(),
      child: HomeViewBody(),

      // child: HomeViewBody(),
    );
  }




}
