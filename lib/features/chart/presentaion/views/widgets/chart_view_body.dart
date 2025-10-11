import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
 import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/today_meds/presentation/manager/cubit/today_meds_cubit.dart';
import 'package:midmate/utils/app_colors.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';

class ChartViewBody extends StatefulWidget {
  const ChartViewBody({super.key});

  @override
  State<ChartViewBody> createState() => _ChartViewBodyState();
}

class _ChartViewBodyState extends State<ChartViewBody> {
  // final Person? currentUser =
  final List<MedModel> today = TodayMedsCubit.todayMeds;

  final List<MedModel> taken = TodayMedsCubit.takenMeds;
  List<LogModel> logs = [];
  @override
  void initState() {
    _getLogs();
    super.initState();
  }

  void _getLogs() async {
    final Person? currentUser = await getIt<UserRepository>().getCurrentUser();
    logs = await getIt<LogsRepo>().getAllLogs(currentUser!.id!);
    log('all logs : $logs');
  }

  // final List<LogModel> logs = getIt<LogsRepo>().getAllLogs();
  final Map<String, int> takenPerDay = {
    'Sat': 4,
    'Sun': 3,
    'Mon': 2,
    'Tue': 8,
    'Wed': 6,
    'Thu': 4,
    'Fri': 2,
  };

  final Map<String, int> missedPerDay = {
    'Sat': 1,
    'Sun': 1,
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
  };

  int takenLength = 0;

  int notTakenLength = 0;

  @override
  Widget build(BuildContext context) {
    for (var log in logs) {
      if (log.status == StatusValues.taken) {
        takenLength++;
      } else {
        notTakenLength++;
      }
    }
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(),
      body: MedsBarChart(
        takenPerDay: {
          'Sat': takenLength,
          'Sun': 3,
          'Mon': 2,
          'Tue': 8,
          'Wed': 6,
          'Thu': 4,
          'Fri': 2,
        },
        missedPerDay: {
          'Sat': notTakenLength,
          'Sun': 1,
          'Mon': 0,
          'Tue': 0,
          'Wed': 0,
          'Thu': 0,
          'Fri': 0,
        },
      ),
    );
  }
}

class MedsBarChart extends StatelessWidget {
  final Map<String, int> takenPerDay;
  final Map<String, int> missedPerDay;

  const MedsBarChart({
    super.key,
    required this.takenPerDay,
    required this.missedPerDay,
  });

  @override
  Widget build(BuildContext context) {
    final days = takenPerDay.keys.toList();

    return BarChart(
      curve: Curves.bounceIn,
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxY(),
        barGroups: _buildBarGroups(days),

        // ✅ Remove all borders
        borderData: FlBorderData(show: false),

        // ✅ Hide background grid
        gridData: FlGridData(show: false),

        // ✅ Hide all titles except bottom (days)
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index < 0 || index >= days.length) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    days[index],
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ),

        // ✅ Disable touch tooltips if you want a static display
        barTouchData: BarTouchData(enabled: true),
        backgroundColor: AppColors.grey,
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<String> days) {
    return List.generate(days.length, (index) {
      final taken = takenPerDay[days[index]] ?? 0;
      final missed = missedPerDay[days[index]] ?? 0;

      return BarChartGroupData(
        x: index,
        barsSpace: 2,
        barRods: [
          BarChartRodData(
            toY: taken.toDouble(),
            color: Colors.green,
            width: 12,
            borderRadius: BorderRadius.circular(4),
          ),
          BarChartRodData(
            toY: missed.toDouble(),
            color: Colors.red,
            width: 12,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  double _getMaxY() {
    final allValues = [...takenPerDay.values, ...missedPerDay.values];
    return (allValues.isEmpty ? 1 : allValues.reduce((a, b) => a > b ? a : b)) +
        1;
  }
}
