import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/home/presentation/views/widgets/app_bar.dart';
import 'package:midmate/features/home/presentation/views/widgets/meds_list_view.dart';
import 'package:midmate/utils/image_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/service_locator.dart';
import 'add_med_modal_bottom_sheet.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MedsCubit medCubit = getIt<MedsCubit>();
  final UserCubit userCubit = getIt<UserCubit>();
  @override
  void initState() {
    medCubit.getUserAllMeds();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        screenName: 'Home',
        context: context,
        // currentUser: currentUser,
      ),
      bottomNavigationBar: CustomBottomBar(),

      floatingActionButton: Align(
        alignment: Alignment.bottomRight,

        child: Padding(
          padding: EdgeInsets.only(right: 30),
          child: FloatingActionButton(
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => getIt<MedsCubit>(),
                    child: AddMedModalBottomSheet(formKey: _formKey),
                  );
                },
              ).then((_) {
                log('getting the meds after adding a new med \n\n');
                medCubit.getUserAllMeds();
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),

      // backgroundColor: AppColors.grey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocBuilder<MedsCubit, MedsState>(
          builder: (context, state) {
            if (state is MedsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetMedsSuccess) {
              return MedsListView(meds: state.meds);
            } else if (state is GetMedsFaluire) {
              // medCubit.getUserAllMeds();
              return Center(child: Text(state.erMessage));
            } else {
              return Center(
                child: Image.asset(ImageController.noMedAddedImage, width: 250),
              );
            }
          },
        ),
      ),
    );
  }
}
