import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/today_meds/presentation/manager/cubit/today_meds_cubit.dart';
import 'package:midmate/utils/service_locator.dart';
import 'widgets/today_meds_view_body.dart';

class MedsTodayView extends StatelessWidget {
  const MedsTodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TodayMedsCubit>()..getTodayMeds(),
      child: TodayMedsViewBody(),
    );
  }
}
