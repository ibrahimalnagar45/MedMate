import 'package:flutter/material.dart';
import 'package:midmate/features/home/presentation/views/widgets/custom_med_list_tile.dart';
import 'package:midmate/utils/models/med_model.dart';
import '../../../../../utils/image_controller.dart';

class MedsListView extends StatelessWidget {
  const MedsListView({super.key, required this.meds});
  final List<MedModel> meds;

  @override
  Widget build(BuildContext context) {
    return meds.isEmpty
        ? Center(
          child: Image.asset(ImageController.noMedAddedImage, width: 250),
        )
        : ListView.builder(
          itemCount: meds.length,
          itemBuilder: (context, index) {
            return CustomMedListTile(medModel: meds[index]);
          },
        );
  }
}
