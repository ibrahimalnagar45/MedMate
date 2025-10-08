import 'package:flutter/material.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';
import 'package:midmate/features/chart/presentaion/manager/cubit/logs_cubit.dart';
import 'package:midmate/utils/text_styles.dart';

class ChartViewBody extends StatelessWidget {
  const ChartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(),
      body: ListView(
        children: List.generate(
          LogsCubit.logs.length,
          (index) => Center(
            child: Text(
              LogsCubit.logs[index].medicationId.toString(),
              style: TextStyles.onBoardingTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
