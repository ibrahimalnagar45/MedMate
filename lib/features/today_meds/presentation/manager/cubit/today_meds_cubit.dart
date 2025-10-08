import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/today_meds/doman/today_meds_repo.dart';
import '../../../../../utils/models/med_model.dart';
import '../../../../../utils/models/user_model.dart';

part 'today_meds_state.dart';

class TodayMedsCubit extends Cubit<TodayMedsState> {
  TodayMedsCubit({required this.medsRepo, required this.userRepo})
    : super(TodayMedsInitial());
  final TodayMedRepo medsRepo;
  final UserRepository userRepo;
  static List<MedModel> todayMeds = [];
  Future<void> getTodayMeds() async {
    emit(GetTodayMedsLoading());
    final Person? currentUser = await userRepo.getCurrentUser();
    try {
      todayMeds = await medsRepo.getTodayMeds(currentUser!.id!);
      log(' today meds are: ${todayMeds.toString()}');
      emit(GetTodayMedsSuccess(meds: todayMeds));
    } catch (e) {
      log('the error when getting today meds is: ${e.toString()}');
      emit(GetTodayMedsFaluire(erMessage: e.toString()));
    }
  }
}
