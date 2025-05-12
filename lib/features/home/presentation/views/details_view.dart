import 'package:flutter/material.dart';
import 'package:midmate/features/home/presentation/views/widgets/details_view_body.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/features/home/presentation/views/widgets/app_bar.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.med});

  final MedModel med;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Details'),
      body: SafeArea(child: DetailsViewBody(med: med)),
    );
  }
}
