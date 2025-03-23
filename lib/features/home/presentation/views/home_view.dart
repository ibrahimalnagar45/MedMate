import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';

import '../../../../utils/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<MedModel> meds = [];
  SqHelper sqHelper = SqHelper();
  @override
  void initState() {
    Future.sync(() async => meds = await Crud.instance.getAllMeds());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Crud.instance.insert(
            MedModel(
              name: 'name2',
              description: 'description',
              type: MedType.injection,
              amount: 4,
              frequency: 3,
              startDate: DateTime(
                DateTime.now().year,
                DateTime.now().day,
                DateTime.now().hour,
              ),
            ),
          );
          setState(() {});
        },
      ),
      backgroundColor: AppColors.grey,
      body:
          meds.isEmpty
              ? Center(child: Text('No Meds'))
              : Center(child: Text(meds.last.name)),

      //  SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Container(
      //           decoration: BoxDecoration(
      //             color: AppColors.teal,
      //             borderRadius: BorderRadius.circular(18),
      //           ),
      //           width: double.infinity,
      //           child: const Column(
      //             children: [
      //               Text('data'),
      //               Text('data'),
      //               Text('data'),
      //               Text('data'),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
