import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/core/widgets/app_bar.dart';
import 'package:midmate/features/home/presentation/views/widgets/meds_list_view.dart';
import 'package:midmate/features/today_meds/presentation/manager/cubit/today_meds_cubit.dart';
import 'package:midmate/features/today_meds/presentation/views/widgets/today_meds_list_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/service_locator.dart';

class TodayMedsViewBody extends StatelessWidget {
  TodayMedsViewBody({super.key});

  final todayMedscubit = getIt<TodayMedsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(),
      appBar: CustomAppBar(screenName: S.current.todayMeds, context: context),
      body: BlocBuilder<TodayMedsCubit, TodayMedsState>(
        builder: (context, state) {
          if (state is GetTodayMedsSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TodayMedsListView(meds: state.meds),
            );
          } else if (state is GetTodayMedsFaluire) {
            return Center(child: Text(state.erMessage));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
