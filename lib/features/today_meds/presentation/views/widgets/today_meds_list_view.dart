import 'package:flutter/material.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
import 'package:midmate/features/today_meds/presentation/manager/cubit/today_meds_cubit.dart';
import 'package:midmate/features/today_meds/presentation/views/widgets/today_med_list_tile.dart';
import 'package:midmate/utils/models/med_model.dart';
import '../../../../../core/models/logs_model.dart';
import '../../../../../utils/image_controller.dart';
import '../../../../../utils/service_locator.dart';
import '../../../../home/data/local_data_base/db_constants.dart';
import '../../../../home/presentation/manager/cubit/meds_cubit.dart';

class TodayMedsListView extends StatefulWidget {
  const TodayMedsListView({super.key, required this.meds});
  final List<MedModel> meds;

  @override
  State<TodayMedsListView> createState() => _TodayMedsListViewState();
}

class _TodayMedsListViewState extends State<TodayMedsListView> {
  final LogsRepo logRepo = getIt<LogsRepo>();

  @override
  Widget build(BuildContext context) {
    bool checked = false;
    return widget.meds.isEmpty
        ? Center(
          child: Image.asset(ImageController.noMedAddedImage, width: 250),
        )
        : ListView.builder(
          itemCount: widget.meds.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              value: checked,
              // onFocusChange: (value) async {
              //   await logRepo.insertLog(
              //     LogModel(
              //       medicationId: widget.meds[index].id!,
              //       takenTime: DateTime.now().toString(),
              //       status: StatusValues.taken,
              //       date: widget.meds[index].getNextTime().toString(),
              //     ),
              //   );

              //   TodayMedsCubit.todayMeds.remove(widget.meds[index]);
              //   // await getIt<TodayMedsCubit>().getTodayMeds();
              //   setState(() => checked = value);
              // },
              
              onChanged: (value) async {
                await logRepo.insertLog(
                  LogModel(
                    medicationId: widget.meds[index].id!,
                    takenTime: DateTime.now().toString(),
                    status: StatusValues.taken,
                    date: widget.meds[index].getNextTime().toString(),
                  ),
                );

                TodayMedsCubit.todayMeds.remove(widget.meds[index]);
                
                setState(() => checked = value!);
              },
              contentPadding: EdgeInsets.zero,
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: TodayMedListTile(medModel: widget.meds[index]),
            );
          },
        );
  }
}
