import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/core/widgets/app_bar.dart';
import 'package:midmate/features/home/presentation/views/widgets/meds_list_view.dart';
import 'package:midmate/utils/image_controller.dart';
import '../../../../../generated/l10n.dart'; 
import 'custom_floating_action_button.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late MedsCubit medCubit;
  @override
  void initState() {
    medCubit = context.read<MedsCubit>();
    Future.sync(() async {
      await medCubit.getAllMeds();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        screenName: S.current.home,
        context: context,
        // currentUser: currentUser,
      ),
      bottomNavigationBar: CustomBottomBar(),

      floatingActionButton: Align(
        alignment: Alignment.bottomRight,

        child: Padding(
          padding: EdgeInsets.only(right: 30),
          child: CustomFloatingActionButton(
            medCubit: medCubit,
            formKey: _formKey,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is SetUserSuccess) {
              medCubit.getAllMeds();
            }
          },
          child: BlocBuilder<MedsCubit, MedsState>(
            builder: (context, state) {
              if (state is GetMedsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetMedsSuccess) {
                return MedsListView(meds: state.meds);
              } else if (state is GetMedsFaluire) {
                return Center(child: Text(state.erMessage));
              } else {
                return Center(
                  child: Image.asset(
                    ImageController.noMedAddedImage,
                    width: 250,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
