import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';
import 'package:midmate/core/widgets/app_bar.dart';
import 'package:midmate/features/today_meds/presentation/manager/cubit/today_meds_cubit.dart';
import 'package:midmate/features/today_meds/presentation/views/widgets/today_meds_list_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/image_controller.dart';

class TodayMedsViewBody extends StatelessWidget {
  const TodayMedsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(),
      appBar: CustomAppBar(
        screenName: S.current.todayMeds,
        context: context,
        autoleading: true,
      ),
      body: BlocBuilder<TodayMedsCubit, TodayMedsState>(
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          if (state.status == TodayMedsStatus.success) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TodayMedsListView(),
            );
          } else if (state.status == TodayMedsStatus.failure) {
            return Center(child: Text(state.errorMessage ?? ''));
          } else if (state.status == TodayMedsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Image.asset(ImageController.noMedAddedImage, width: 250),
            );
          }
        },
      ),
    );
  }
}
