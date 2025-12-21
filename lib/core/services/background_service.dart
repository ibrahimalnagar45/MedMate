import 'package:flutter/material.dart';
import 'package:midmate/features/chart/data/repos/logs_repo_impl.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:workmanager/workmanager.dart';

import '../../features/home/doman/repository/user_repo.dart';
import '../../features/today_meds/doman/today_meds_repo.dart';
import '../models/logs_model.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    await serviceLocatorSetup();

    final user = await getIt<UserRepository>().getCurrentUser();
    if (user == null) return true;

    final now = DateTime.now();

    switch (task) {
      // 🔁 Update next medication time
      case "Update_Med_Dates":
        final meds = await getIt<TodayMedRepo>().getTodayMeds(user.id!);

        for (var med in meds) {
          if (med.nextTime!.isBefore(now)) {
            await getIt<TodayMedRepo>().updateNextTime(med);
          }
        }
        break;

      // ❌ Mark missed doses
      case "daily_missed_check":
        final logs = await getIt<LogsRepoImpl>().getAllLogs(user.id!);

        for (var dose in logs) {
          if (dose.status == StatusValues.pending &&
              DateTime.parse(dose.date).isBefore(now)) {
            await getIt<LogsRepoImpl>().updateLog(
              logModel: dose,
              newStatus: StatusValues.missed,
            );
          }
        }
        break;
    }

    return true;
  });
}
