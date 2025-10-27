import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/app_colors.dart';
import '../../manager/cubit/meds_cubit.dart';
import 'add_med_modal_bottom_sheet.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.medCubit,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final MedsCubit medCubit;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.blue,
      foregroundColor: AppColors.white,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isDismissible: false,

          isScrollControlled: true,
          builder: (context) {
            return BlocProvider.value(
              value: medCubit,
              child: AddMedModalBottomSheet(formKey: _formKey),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
