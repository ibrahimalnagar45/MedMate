import 'package:flutter/material.dart';
import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
import 'package:midmate/features/home/doman/repository/meds_repo.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/service_locator.dart';
import '../../../../../utils/models/user_model.dart';

class AllLogsListView extends StatefulWidget {
  const AllLogsListView({super.key});

  @override
  State<AllLogsListView> createState() => _AllLogsListViewState();
}

class _AllLogsListViewState extends State<AllLogsListView> {
  List<LogModel> todayLogs = [];
  List<MedModel> meds = [];
  Person? currentUser;
  @override
  void initState() {
    Future.sync(() async {
      await getTodayLogs();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todayLogs.length,
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            "${todayLogs[index].date} \t ${todayLogs[index].status}  \t ${todayLogs[index].medicationId} ",
          ),
        );
      },
    );
  }

  Future<void> getTodayLogs() async {
    currentUser = await getIt<UserRepository>().getCurrentUser();
    todayLogs = await getIt<LogsRepo>().getTodayLogs(currentUser!.id!);
    for (var log in todayLogs) {
      MedModel? med = await getIt<MedsRepository>().getMed(log.medicationId);
      if (med != null) {
        meds.add(med);
      }
    }
    setState(() {});
  }
}
