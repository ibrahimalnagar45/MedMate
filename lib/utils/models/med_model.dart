class MedModel {
  final String name;
  final String description;
  final MedType type;
  final double amount;
  final int frequency;
  final DateTime startDate;
  static int id = 0;
  MedModel({
    required this.name,
    required this.description,
    required this.type,
    required this.amount,
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
      'amount': amount.toString(),
      'frequency': frequency.toString(),
      'startDate': startDate.toIso8601String(),
    };
  }

  factory MedModel.fromMap(Map<String, dynamic> map) {
    return MedModel(
      name: map['name'],
      description: map['description'],
      type: getType(map['type']),
      amount: map['amount'],
      frequency: map['frequency'],
      startDate: DateTime.parse(map['startDate']),
    );
  }


}

  MedType getType(String type) {
    switch (type) {
      case 'pill':
        return MedType.pill;
      case 'powder':
        return MedType.powder;
      case 'syrup':
        return MedType.syrup;
      case 'drop':
        return MedType.drop;
      case 'solution':
        return MedType.solution;
      case 'cream':
        return MedType.cream;
      case 'injection':
        return MedType.injection;
      case 'inhaler':
        return MedType.inhaler;
      default:
        return MedType.pill;
    }
  }

enum MedType { pill, powder, syrup, drop, solution, cream, injection, inhaler,

 

 }
