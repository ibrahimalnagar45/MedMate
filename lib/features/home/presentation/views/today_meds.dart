import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/widgets/meds_list_view.dart';
import 'package:midmate/utils/models/med_model.dart';

import '../../../../utils/image_controller.dart';
import 'widgets/meds_today_view_body.dart';

class MedsToday extends StatefulWidget {
  const MedsToday({super.key});

  @override
  State<MedsToday> createState() => _MedsTodayState();
}

class _MedsTodayState extends State<MedsToday> {
  List<MedModel> todayMeds = [];
  @override
  void initState() {
    MedsCubit().getTodayMeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedsCubit(),
      child: MedsTodayViewBody(),
    );
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(),

      body: BlocBuilder<MedsCubit, MedsState>(
        builder: (context, state) {
          if (state is GetMedsSuccess) {
            return MedsListView(meds: state.meds);
          } else if (state is GetTodayMedsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMedsFaluire) {
            return Center(child: Text(state.erMessage));
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
