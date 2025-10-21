import 'package:flutter/material.dart';
import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/today_meds/presentation/manager/cubit/today_meds_cubit.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/text_styles.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/models/user_model.dart';
import '../../../../../utils/service_locator.dart';
import 'today_med_list_tile.dart';

class TodayMedsListView extends StatefulWidget {
  const TodayMedsListView({super.key, required this.meds});
  final List<MedModel> meds;

  @override
  State<StatefulWidget> createState() => TodayMedsListViewState();
}

class TodayMedsListViewState extends State<TodayMedsListView> {
  @override
  Widget build(BuildContext context) {
    return const TodayMedList();
  }
}

class TodayMedList extends StatefulWidget {
  const TodayMedList({super.key});

  @override
  State<TodayMedList> createState() => _TodayMedListState();
}

class _TodayMedListState extends State<TodayMedList> {
  final LogsRepo logRepo = getIt<LogsRepo>();
  final UserRepository userRepo = getIt<UserRepository>();
  Person? currentUser;

  late List<MedModel> todayMeds;
  late List<MedModel> takenMeds;
  // final List<LogModel> logs= [];
  final medsCubit = getIt<TodayMedsCubit>();

  @override
  void initState() {
    super.initState();
    Future.sync(() async {
      currentUser = await userRepo.getCurrentUser();
    });
    medsCubit.getTodayMeds();
    todayMeds = List.from(TodayMedsCubit.todayMeds);
    takenMeds = List.from(TodayMedsCubit.takenMeds);
    // for (var log in ) {}
  }

  Future<void> markAsTaken(MedModel med) async {
    // List<LogModel> allLogs = await logRepo.getAllLogs(currentUser!.id!);
    LogModel? logModel = await logRepo.getlogByMed(med: med); 
    
    await logRepo.updateLog(
      logId: logModel!.id!,
      newStatus: StatusValues.taken,
    );

    setState(() {
      todayMeds.remove(med);
      takenMeds.add(med);
      TodayMedsCubit.todayMeds = List.from(todayMeds);
      TodayMedsCubit.takenMeds = List.from(takenMeds);
    });
  }

  Future<void> undoTaken(MedModel med) async {
    LogModel? logModel = await logRepo.getlogByMed(med: med);
    await logRepo.updateLog(
      logId: logModel!.id!,
      newStatus: StatusValues.pending,
    );

    setState(() {
      takenMeds.remove(med);
      todayMeds.add(med);
      TodayMedsCubit.todayMeds = List.from(todayMeds);
      TodayMedsCubit.takenMeds = List.from(takenMeds);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (todayMeds.isEmpty && takenMeds.isEmpty) {
      return const SizedBox();
    }

    return SingleChildScrollView(
      child: Column(
        children: List.generate(todayMeds.length, (index) {
          if (index == todayMeds.length - 1) {
            if (takenMeds.isNotEmpty) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: Divider(endIndent: 5)),
                      Text('Taken', style: TextStyles.regBlackTextStyle),
                      const Expanded(child: Divider(indent: 5)),
                    ],
                  ),
                  const SizedBox(height: 10),
                 ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: takenMeds.length,
            itemBuilder: (context, index) {
              final med = takenMeds[index];
              return Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    MedIcon(medType: med.type!),
                    const SizedBox(width: 10),
                    MedInfoText(medModel: med),
                    const Spacer(),
                    IconButton(
                      tooltip: "Undo taken",
                      onPressed: () => undoTaken(med),
                      icon: Icon(Icons.redo, color: AppColors.green),
                    ),
                  ],
                ),
              );
            },
          ),
                
                ],
              );
            }
          }
          return CheckboxListTile(
            value: false,
            onChanged: (_) => markAsTaken(todayMeds[index]),
            contentPadding: EdgeInsets.zero,
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: TodayMedListTile(medModel: todayMeds[index]),
          );
        }),
      ),
    );
    return Column(
      children: [
        // 🟢 Today meds list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: todayMeds.length,
          itemBuilder: (context, index) {
            final med = todayMeds[index];
            return CheckboxListTile(
              value: false,
              onChanged: (_) => markAsTaken(med),
              contentPadding: EdgeInsets.zero,
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: TodayMedListTile(medModel: med),
            );
          },
        ),

        if (takenMeds.isNotEmpty) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: Divider(endIndent: 5)),
              Text('Taken', style: TextStyles.regBlackTextStyle),
              const Expanded(child: Divider(indent: 5)),
            ],
          ),
          const SizedBox(height: 10),

          // 🔵 Taken meds list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: takenMeds.length,
            itemBuilder: (context, index) {
              final med = takenMeds[index];
              return Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    MedIcon(medType: med.type!),
                    const SizedBox(width: 10),
                    MedInfoText(medModel: med),
                    const Spacer(),
                    IconButton(
                      tooltip: "Undo taken",
                      onPressed: () => undoTaken(med),
                      icon: Icon(Icons.redo, color: AppColors.green),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
