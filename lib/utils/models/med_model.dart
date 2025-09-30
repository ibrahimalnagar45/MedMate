import 'package:flutter/widgets.dart';
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
      debugPrint('next time is null');
    }
    return nextTime;
  }

  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'description': description,
      'type': type.toString(),
      'amount': dose.toString(),
      'frequency': frequency.toString(),
      'startDate': startDate == null ? startDate : startDate!.toIso8601String(),
      'createdAt': createdAt == null ? createdAt : createdAt!.toIso8601String(),
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory MedModel.fromMap(Map<String, dynamic> map) {
    return MedModel(
      id: map[DbConstants.medsColumnId],
      name: map[DbConstants.medsColumnName],
      description: map[DbConstants.medsColumnDescription],
      type: MedModel.newMed().getType(map[DbConstants.medsColumnType]),
      dose: map[DbConstants.medsColumnAmount],
      frequency: map[DbConstants.medsColumnFrequency],
      startDate: DateTime.parse(map[DbConstants.medsColumnStartDate]),
      createdAt: DateTime.parse(map[DbConstants.medsColumnCreatedAt]),
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
