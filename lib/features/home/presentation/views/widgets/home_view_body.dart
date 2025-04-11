import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/widgets/meds_list_view.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
 
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedsCubit, MedsState>(
      builder: (context, state) {
        if (state is MedsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetMedsSuccess) {
          return MedsListView(meds: state.meds);
        } else {
          return const Center(child: Text('No Meds Yet'));
        }
      },
    );
  }
}
