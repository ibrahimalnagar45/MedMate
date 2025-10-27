import 'package:flutter/material.dart';
import 'package:midmate/core/widgets/app_bar.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';
import 'package:midmate/features/today_meds/presentation/views/widgets/all_logs_list_view.dart';
import 'package:midmate/generated/l10n.dart';

class TodayLogsView extends StatelessWidget {
  const TodayLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(screenName: S.current.todayLogs, context: context),
      bottomNavigationBar: CustomBottomBar(),

      body: AllLogsListView(),
    );
  }
}
