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
   
  final List<MedModel> today = TodayMedsCubit.todayMeds;
  final List<MedModel> taken = TodayMedsCubit.takenMeds;
  List<LogModel> logs = [];
    Map<String, int> takenMap = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'Sun': 0,
  };
  Map<String, int> notTakenMap = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'Sun': 0,
  };
 

  @override
  void initState() {
    _getData();
     super.initState();
  }

  void _getData() async {
    final Person? currentUser = await getIt<UserRepository>().getCurrentUser();
    logs = await getIt<LogsRepo>().getAllLogs(currentUser!.id!);
    for (var log in logs) {
      setState(() {
        if (isDateInCurrentWeek(DateTime.parse(log.date))) {
          if (log.status == StatusValues.taken) {
            takenMap[log.getWeekDay()] = takenMap[log.getWeekDay()]! + 1;
          } else {
            notTakenMap[log.getWeekDay()] = notTakenMap[log.getWeekDay()]! + 1;
          }
        }
      });
    }
    log('all logs : $logs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(),
      body: MedsBarChart(takenPerDay: takenMap, missedPerDay: notTakenMap),
    );
  }
}

bool isDateInCurrentWeek(DateTime date) {
  DateTime now = DateTime.now();

  // Start of this week (Monday)
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  startOfWeek = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

  // End of this week (Sunday)
  DateTime endOfWeek = startOfWeek.add(
    const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
  );

  return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
      date.isBefore(endOfWeek.add(const Duration(seconds: 1)));
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
