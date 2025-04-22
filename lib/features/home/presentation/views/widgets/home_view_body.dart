import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/services/local_notification.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/widgets/app_bar.dart';
import 'package:midmate/features/home/presentation/views/widgets/meds_list_view.dart';
import 'package:midmate/main.dart';
import 'package:midmate/utils/text_styles.dart';

import '../../../../../utils/app_colors.dart';
import 'add_med_modal_bottom_sheet.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 30.0, bottom: 10),
          child: FloatingActionButton(
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,

            // onPressed: () {
            //   // LocalNotification(
            //   //   navigatorKey: navigatorKey,
            //   // ).showScheduledRepeatedNotification(
            //   //   title: 'this is the time to take ur medicine medModel.name}',
            //   //   body: 'this is the time to take ur medicine medModel.name}',
            //   //   date: DateTime(0, 0, 0, 0, 1, 4, 0, 0),
            //   //   // id: medModel.id,
            //   // );
            //   LocalNotification(
            //     navigatorKey: navigatorKey,
            //   ).cancleAllNotifications();
            // },
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => MedsCubit(),
                    child: AddMedModalBottomSheet(formKey: _formKey),
                  );
                },
              ).then((_) {
                BlocProvider.of<MedsCubit>(context).getAllMed();
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
      backgroundColor: AppColors.grey,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocBuilder<MedsCubit, MedsState>(
          builder: (context, state) {
            if (state is MedsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetMedsSuccess) {
              return MedsListView(meds: state.meds);
            } else if (state is GetMedsFaluire) {
              return Center(child: Text(state.erMessage));
            } else {
              return const Center(
                child: Text('No Meds Yet', style: TextStyles.hintTextStyle),
              );
            }
          },
        ),
      ),
    );
  }
}
