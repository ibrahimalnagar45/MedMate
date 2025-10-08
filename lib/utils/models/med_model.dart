import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:midmate/core/functions/check_med_next_time.dart';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';

class MedModel {
  // 6 params
  String? name;
  String? description;
  MedType? type;
  double? dose;
  int? frequency;
  DateTime? startDate;
  DateTime? nextTime;
  DateTime? createdAt;
  int? id;
  // bool? checked = false;
  List<DateTime> logs = [];
  MedModel.newMed();
  MedModel({
    required this.name,
    required this.description,
    required this.type,
    required this.dose,
    required this.createdAt,
    required this.frequency,
    required this.startDate,
    this.id,
    this.nextTime,
  }) {
    nextTime = getNextTime();
  }

  String getFormattedNextTime() {
    checkMedNextTime(this);

    if (nextTime == null) {
      checkMedNextTime(this);
    }
    return DateFormat('dd/MM-hh:mm a').format(nextTime!);
  }

  void setNextTime() {
    if (nextTime == null) {
      nextTime = startDate!.add(Duration(hours: frequency!));
    } else {
      nextTime = nextTime!.add(Duration(hours: frequency!));
    }
  }

  DateTime? getNextTime() {
    if (nextTime == null) {
      setNextTime();
      log('next time is null');
    }
    return nextTime;
  }

  Map<String, dynamic> toMap() {
    final map = {
      MedsTable.medName: name,
      // MedsTable.medId: id,
      MedsTable.medDescription: description,
      MedsTable.medType: type.toString(),
      MedsTable.medAmount: dose == null ? dose : dose.toString(),
      MedsTable.medFrequency: frequency.toString(),
      MedsTable.medStartDate:
          startDate == null ? startDate : startDate!.toIso8601String(),
      MedsTable.medCreatedAt:
          createdAt == null ? createdAt : createdAt!.toIso8601String(),
    };

    if (id != null) {
      map[MedsTable.medId] = id;
    }
    return map;
  }

  factory MedModel.fromMap(Map<String, dynamic> map) {
    return MedModel(
      id: map[MedsTable.medId],
      name: map[MedsTable.medName],
      description: map[MedsTable.medDescription],
      type: MedModel.newMed().getType(map[MedsTable.medType]),
      dose: map[MedsTable.medAmount],
      frequency: map[MedsTable.medFrequency],
      startDate: DateTime.parse(map[MedsTable.medStartDate]),
      createdAt: DateTime.parse(map[MedsTable.medCreatedAt]),
    );
  }

  @override
  String toString() {
    return 'id:$id name:$name, description:$description,  type:$type, donse:$dose, frequency:$frequency, createdAt:$createdAt,startDate:$startDate , nextTime:$nextTime';
  }

  MedType getType([String? type]) {
    if (type == 'MedType.pill') {
      return MedType.pill;
    } else if (type == 'MedType.powder') {
      return MedType.powder;
    } else if (type == 'MedType.syrup') {
      return MedType.syrup;
    } else if (type == 'MedType.drop') {
      return MedType.drop;
    } else if (type == 'MedType.cream') {
      return MedType.cream;
    } else if (type == 'MedType.injection') {
      return MedType.injection;
    } else if (type == 'MedType.inhaler') {
      return MedType.inhaler;
    } else {
      return MedType.pill;
    }
  }
}

enum MedType { pill, powder, syrup, drop, cream, injection, inhaler }
