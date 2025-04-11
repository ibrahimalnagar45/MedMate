import 'package:flutter/material.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';

class MedsListView extends StatelessWidget {
  const MedsListView({super.key, required this.meds});
  final List<MedModel> meds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meds.length,
      itemBuilder: (context, index) {
        // return Text(getIt<UserModel>().name.toString());

        return ListTile(
          title: Text(meds[index].name),
          subtitle: Text(meds[index].description),
        );
      },
    );
  }
}
