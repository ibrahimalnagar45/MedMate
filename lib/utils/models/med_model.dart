import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';

import '../../generated/l10n.dart';

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
  List<DateTime> logs = [];
  MedModel.newMed() {
    // id++;
  }
  MedModel({
    required this.name,
    required this.description,
    required this.type,
    required this.dose,
    required this.createdAt,
    required this.frequency,
    required this.startDate,
    this.id,
  }) {
    // id++;
  }

  String getFormattedNextTime() {
    if (nextTime == null) {
      setNextTime();
    }
    return DateFormat('dd/MM-hh:mm a').format(nextTime!);
  }

  void setNextTime() {
    if (nextTime == null) {
      nextTime = createdAt!.add(
        Duration(
          hours: frequency! + startDate!.hour,

          // days: startDate!.day == DateTime.now().day ? startDate!.day : 0,
        ),
      );
    } else {
      nextTime = nextTime!.add(Duration(hours: frequency!));
    }
  }

  getNextTime() {
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
      id: map[DbConstants.columnId],
      name: map[DbConstants.columnName],
      description: map[DbConstants.columnDescription],
      type: MedModel.newMed().getType(map[DbConstants.columnType]),
      dose: map[DbConstants.columnAmount],
      frequency: map[DbConstants.columnFrequency],
      startDate: DateTime.parse(map[DbConstants.columnStartDate]),
      createdAt: DateTime.parse(map[DbConstants.columnCreatedAt]),
    );
  }

  @override
  String toString() {
    return 'id:$id name:$name, description:$description,  type:$type, donse:$dose, frequency:$frequency, startDate:$startDate  , nextTime:$nextTime, createdAt:$createdAt';
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

// dose amounts for each type of med
/**
 Pill / Tablet / Capsule

Dose: tablet, pill, capsule

Arabic: قرص، حبة، كبسولة

Syrup / Liquid

Dose: ml, teaspoon, tablespoon

Arabic: مل، ملعقة صغيرة، ملعقة كبيرة

Inhaler

Dose: puff

Arabic: بخة

Injection

Dose: ml, dose, units (IU/mg/etc.)

Arabic: مل، جرعة، وحدة

Drop (e.g., eye/ear)

Dose: drop

Arabic: قطرة

Cream / Ointment / Gel

Dose: thin layer, pea-sized amount, cm

Arabic: طبقة رقيقة، كمية بحجم حبة البازلاء، سنتيمتر

Powder

Dose: sachet, scoop, gram

Arabic: كيس، مكيال، غرام
 */
