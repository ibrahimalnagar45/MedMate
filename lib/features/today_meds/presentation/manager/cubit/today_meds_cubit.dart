// import 'dart:developer';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
// import 'package:midmate/features/home/doman/repository/user_repo.dart';
// import 'package:midmate/features/today_meds/doman/today_meds_repo.dart';
// import '../../../../../core/models/logs_model.dart';
// import '../../../../../utils/models/med_model.dart';
// import '../../../../../utils/models/user_model.dart';

// part 'today_meds_state.dart';

// class TodayMedsCubit extends Cubit<TodayMedsState> {
//   TodayMedsCubit({
//     required this.medsRepo,
//     required this.userRepo,
//     required this.logRepo,
//   }) : super(TodayMedsInitial());
//   final TodayMedRepo medsRepo;
//   final LogsRepo logRepo;
//   final UserRepository userRepo;
//   static List<MedModel> todayMeds = [];
//   static List<MedModel> takenMeds = [];
//   Future<List<MedModel>> getTodayMeds() async {
//     emit(GetTodayMedsLoading());
//     final Person? currentUser = await userRepo.getCurrentUser();
//     try {
//       todayMeds = await medsRepo.getTodayMeds(currentUser!.id!);
//       log(' today meds are: ${todayMeds.toString()}');
//       emit(GetTodayMedsSuccess(meds: todayMeds));
//     } catch (e) {
//       log('the error when getting today meds is: ${e.toString()}');
//       emit(GetTodayMedsFaluire(erMessage: e.toString()));
//     }
//     return todayMeds;
//   }

//   Future<void> markAsTaken(MedModel med) async {
//     try {
//       if (todayMeds.contains(med) && !takenMeds.contains(med)) {
//         LogModel? logModel = await logRepo.getlogByMed(med: med);
//         log('log id: ${logModel?.id}');
//         if (logModel != null) {
//           await logRepo.updateLog(
//             logModel: logModel,
//             newStatus: StatusValues.taken,
//           );
//           todayMeds.remove(med);
//           takenMeds.add(med);
//           TodayMedsCubit.todayMeds = List.from(todayMeds);
//           TodayMedsCubit.takenMeds = List.from(takenMeds);
//         }
//       }
//       emit(MarkMedAsTakenSuccess());
//     } on Exception catch (e) {
//       emit(MarkMedAsTakenFailure(erMessage: e.toString()));
//     }
//   }

//   Future<void> undoTaken(MedModel med) async {
//     try {
//       if (takenMeds.contains(med) && !todayMeds.contains(med)) {
//         LogModel? logModel = await logRepo.getlogByMed(med: med);
//         await logRepo.updateLog(
//           logModel: logModel!,
//           newStatus: StatusValues.pending,
//         );

//         takenMeds.remove(med);
//         todayMeds.add(med);
//         TodayMedsCubit.todayMeds = List.from(todayMeds);
//         TodayMedsCubit.takenMeds = List.from(takenMeds);
//       }
//       emit(UndoMedTakenSuccess());
//     } on Exception catch (e) {
//       emit(UndoMedTakenFailure(erMessage: e.toString()));
//     }
//   }

//   List<MedModel> getTakenMeds() {
//     return takenMeds;
//   }
// }

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/today_meds/doman/today_meds_repo.dart';
import '../../../../../core/models/logs_model.dart';
import '../../../../../utils/models/med_model.dart';
import '../../../../../utils/models/user_model.dart';

part 'today_meds_state.dart';

class TodayMedsCubit extends Cubit<TodayMedsState> {
  TodayMedsCubit({
    required this.todayMedsRepo,
    required this.userRepo,
    required this.logRepo,
  }) : super(TodayMedsInitial());

  final TodayMedRepo todayMedsRepo;
  final LogsRepo logRepo;
  final UserRepository userRepo;

  List<MedModel> todayMeds = [];
  List<MedModel> takenMeds = [];

  Future<void> getTodayMeds() async {
    emit(GetTodayMedsLoading());
    try {
      final Person? currentUser = await userRepo.getCurrentUser();
      if (currentUser == null) throw Exception("No current user found");

      todayMeds = await todayMedsRepo.getTodayMeds(currentUser.id!);
      takenMeds = []; // reset taken meds for today
      log('Today meds: $todayMeds');
      emit(GetTodayMedsSuccess(meds: todayMeds));
    } catch (e) {
      log('Error getting today meds: $e');
      emit(GetTodayMedsFaluire(erMessage: e.toString()));
    }
  }

  Future<void> markAsTaken(MedModel med) async {
    try {
      if (todayMeds.contains(med) && !takenMeds.contains(med)) {
        final LogModel? logModel = await logRepo.getlogByMed(med: med);
        if (logModel != null) {
          await logRepo.updateLog(
            logModel: logModel,
            newStatus: StatusValues.taken,
          );
          todayMeds.remove(med);
          takenMeds.add(med);
          emit(
            MarkMedAsTakenSuccess(todayMeds: todayMeds, takenMeds: takenMeds),
          );
        }
      }
    } catch (e) {
      emit(MarkMedAsTakenFailure(erMessage: e.toString()));
    }
  }

  Future<void> undoTaken(MedModel med) async {
    try {
      if (takenMeds.contains(med) && !todayMeds.contains(med)) {
        final LogModel? logModel = await logRepo.getlogByMed(med: med);
        if (logModel != null) {
          await logRepo.updateLog(
            logModel: logModel,
            newStatus: StatusValues.pending,
          );
          takenMeds.remove(med);
          todayMeds.add(med);
          emit(UndoMedTakenSuccess(todayMeds: todayMeds, takenMeds: takenMeds));
        }
      }
    } catch (e) {
      emit(UndoMedTakenFailure(erMessage: e.toString()));
    }
  }

  removeMedFromTaken(MedModel med) {
    takenMeds.remove(med);
  }

  addMedTotaken(MedModel med) {
    takenMeds.add(med);
  }

  addMedToTodayMeds(MedModel med) {
    todayMeds.add(med);
  }

  removeMedFromTodayMeds(MedModel med) {
    todayMeds.remove(med);
  }
}
