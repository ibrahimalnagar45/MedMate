import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/presentation/views/widgets/app_bar.dart';
import 'package:midmate/features/home/presentation/views/widgets/details_view_body.dart';
import 'package:midmate/utils/models/med_model.dart'; 

import '../../../../core/managers/user_cubit/user_cubit.dart';

class DetailsView extends StatelessWidget {
  DetailsView({super.key, required this.med});

  final MedModel med;
  final UserCubit userCubit = UserCubit();

  @override
  Widget build(BuildContext context) {
          
    return Scaffold(
      appBar: CustomAppBar(

        screenName: 'Details',
        context: context,
        // currentUser: getIt<UserCubit>().getCurrentUser(),
      ),
      body: SafeArea(child: DetailsViewBody(med: med)),
    );
  }
}
