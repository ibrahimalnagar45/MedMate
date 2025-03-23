import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedsCubit, MedsState>(
      builder: (context, state) {
        if (state is MedsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetMedsSuccess) {
          return ListView.builder(
            itemCount: state.meds.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.meds[index].name),
                subtitle: Text(state.meds[index].description),
              );
            },
          );
        }
        else{ 
          return const Center(child: Text('No Meds'));
        }
      },
    );
  }
}
