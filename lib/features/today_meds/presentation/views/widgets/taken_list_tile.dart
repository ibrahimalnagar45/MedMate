import 'package:flutter/material.dart';
import 'package:midmate/features/today_meds/presentation/manager/cubit/today_meds_cubit.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'today_med_list_tile.dart';

class TakenListTile extends StatefulWidget {
  const TakenListTile({super.key, required this.medModel});
  final MedModel medModel;

  @override
  State<TakenListTile> createState() => _TakenListTileState();
}

class _TakenListTileState extends State<TakenListTile> {
  // bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          MedIcon(medType: widget.medModel.type!),
          const SizedBox(width: 10),
          MedInfoText(medModel: widget.medModel),
          Spacer(),
          IconButton(
            onPressed: () {
              TodayMedsCubit.todayMeds.add(widget.medModel);
              TodayMedsCubit.takenMeds.remove(widget.medModel);
              setState(() {});
            },
            icon: Icon(Icons.check, color: AppColors.green),
          ),
        ],
      ),
    );
  }
}
