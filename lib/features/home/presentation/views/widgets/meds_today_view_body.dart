import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/widgets/meds_list_view.dart';
import 'package:midmate/utils/models/med_model.dart';

import '../../../../../utils/image_controller.dart';

class MedsTodayViewBody extends StatefulWidget {
  const MedsTodayViewBody({super.key});

  @override
  State<MedsTodayViewBody> createState() => _MedsTodayViewBodyState();
}

class _MedsTodayViewBodyState extends State<MedsTodayViewBody> {
  List<MedModel> todayMeds = [];
  @override
  void initState() {
    MedsCubit().getTodayMeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(),

      body: BlocBuilder<MedsCubit, MedsState>(
        builder: (context, state) {
          if (state is GetTodayMedsSuccess) {
            if (state.meds.isEmpty) {
              return Center(
                child: Image.asset(ImageController.noMedAddedImage, width: 250),
              );
            }
            return MedsListView(meds: state.meds);
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
