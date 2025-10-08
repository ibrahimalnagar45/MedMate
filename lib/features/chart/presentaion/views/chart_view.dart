import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:midmate/features/chart/presentaion/manager/cubit/logs_cubit.dart';

import '../../../../utils/service_locator.dart';
import 'widgets/chart_view_body.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LogsCubit>()..getUserLogs(),
      child: const ChartViewBody(),
    );
  }
}
