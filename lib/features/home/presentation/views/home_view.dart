 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
 import 'package:midmate/features/home/presentation/views/widgets/home_view_body.dart'; 
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
   
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedsCubit()..getAllMed(),
      child: HomeViewBody(),

      // child: HomeViewBody(),
    );
  }




}
