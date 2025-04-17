import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midmate/features/home/presentation/views/widgets/custom_med_list_tile.dart';
import 'package:midmate/features/home/presentation/views/widgets/custom_med_type_icon.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/image_controller.dart';
import 'package:midmate/utils/models/med_model.dart';

class MedsListView extends StatelessWidget {
  const MedsListView({super.key, required this.meds});
  final List<MedModel> meds;

  @override
  Widget build(BuildContext context) {
    log(meds.toString());
    return meds.isEmpty
        ? const Center(child: Text('لا يوجد اي ادوية حتي لان '))
        : ListView.builder(
          itemCount: meds.length,
          itemBuilder: (context, index) {
            return CustomMedListTile(medModel: meds[index]);
          },
        );
  }
}
