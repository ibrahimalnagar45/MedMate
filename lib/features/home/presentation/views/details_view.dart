import 'package:flutter/material.dart';
import 'package:midmate/features/home/presentation/views/widgets/details_view_body.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/models/med_model.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.med});

  final MedModel med;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        centerTitle: true,
        title: const Text(
          'تفاصيل الدواء',
          style: TextStyle(color: AppColors.white),
        ),

        backgroundColor: AppColors.blue,
      ),
      body: SafeArea(child: DetailsViewBody(med: med)),
    );
  }
}
