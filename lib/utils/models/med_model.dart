import 'package:intl/intl.dart';
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
  static int id = 0;
  MedModel.newMed() {
    // createdAt = DateTime.now();
  }
  MedModel({
    required this.name,
    required this.description,
    required this.type,
    required this.dose,
    this.createdAt,
    required this.frequency,
    required this.startDate,
  }) {
    id++;
    // createdAt = DateTime.now();
  }

  String getFormattedNextTime() {
    if (nextTime == null) {
      setNextTime();
    }
    return DateFormat('dd/MM-hh:mm a').format(nextTime!);
  }

  void setNextTime() {
    nextTime = createdAt!.add(
      Duration(
        hours: frequency! + startDate!.hour,

        // days: startDate!.day == DateTime.now().day ? startDate!.day : 0,
      ),
    );
  }

  getNextTime() {
    if (nextTime == null) {
      setNextTime();
    }
    return nextTime;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'type': type.toString(),
      'amount': dose.toString(),
      'frequency': frequency.toString(),
      'startDate': startDate == null ? startDate : startDate!.toIso8601String(),
    };
  }

  factory MedModel.fromMap(Map<String, dynamic> map) {
    return MedModel(
      name: map[DbConstants.columnName],
      description: map[DbConstants.columnDescription],
      type: MedModel.newMed().getType(map[DbConstants.columnType]),
      dose: map[DbConstants.columnAmount],
      frequency: map[DbConstants.columnFrequency],
      startDate: DateTime.parse(map[DbConstants.columnStartDate]),
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

  String? getArabicMedType() {
    if (type != null) {
      switch (type!) {
        case MedType.powder:
          return 'مسحوق';
        case MedType.pill:
          return 'قرص';
        case MedType.syrup:
          return 'شراب';
        case MedType.drop:
          return 'قطرة';
        case MedType.cream:
          return 'كريم';
        case MedType.injection:
          return 'حقنة';
        case MedType.inhaler:
          return 'بخاخ';
      }
    }
  }
}

String? getArabicMedType(MedType type) {
  switch (type) {
    case MedType.powder:
      return 'مسحوق';
    case MedType.pill:
      return 'قرص';
    case MedType.syrup:
      return 'شراب';
    case MedType.drop:
      return 'قطرة';
    case MedType.cream:
      return 'كريم';
    case MedType.injection:
      return 'حقنة';
    case MedType.inhaler:
      return 'بخاخ';
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
