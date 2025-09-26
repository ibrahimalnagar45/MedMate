import 'package:flutter/material.dart';
import 'package:midmate/core/widgets/bottom_bar.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: CustomBottomBar());
  }
}
