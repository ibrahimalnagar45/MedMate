import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart'; 
import 'package:midmate/utils/service_locator.dart';
import 'widgets/today_meds_view_body.dart';

class MedsToday extends StatelessWidget {
  const MedsToday({super.key});
 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MedsCubit>(),
      child: TodayMedsViewBody(),
    );
   }
}
