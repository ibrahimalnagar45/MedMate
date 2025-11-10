import 'package:flutter/material.dart';
import 'package:midmate/core/widgets/app_bar.dart';
import 'package:midmate/features/home/presentation/views/widgets/details_view_body.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/service_locator.dart';
import '../../../../core/managers/user_cubit/user_cubit.dart';
import '../../../../generated/l10n.dart';

class DetailsView extends StatelessWidget {
  DetailsView({super.key, required this.med});

  final MedModel med;
  final UserCubit userCubit = getIt<UserCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        screenName: S.current.description,
        context: context,
        
        // currentUser: getIt<UserCubit>().getCurrentUser(),
      ),
      body: SafeArea(child: DetailsViewBody(med: med)),
    );
  }
}
