import 'package:midmate/features/home/data/local_data_base/db_constants.dart';

class MedModel {
  // 6 params
  String? name;
  String? description;
  MedType? type;
  double? donse;
  int? frequency;
  DateTime? startDate;
  static int id = 0;
  MedModel.newMed();
  MedModel({
    required this.name,
    required this.description,
    required this.type,
    required this.donse,
    required this.frequency,
    required this.startDate,
  }) {
    id++;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'type': type.toString(),
      'amount': donse.toString(),
      'frequency': frequency.toString(),
      'startDate': startDate == null ? startDate : startDate!.toIso8601String(),
    };
  }

  factory MedModel.fromMap(Map<String, dynamic> map) {
    return MedModel(
      name: map[DbConstants.columnName],
      description: map[DbConstants.columnDescription],
      type: getType(map[DbConstants.columnType]),
      donse: map[DbConstants.columnAmount],
      frequency: map[DbConstants.columnFrequency],
      startDate: DateTime.parse(map[DbConstants.columnStartDate]),
    );
  }

  @override
  String toString() {
    return 'name:$name, description:$description,  type:$type, donse:$donse, frequency:$frequency, startDate:$startDate';
  }
}

MedType getType(String type) {
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

String getArabicMedType(MedType type) {
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
