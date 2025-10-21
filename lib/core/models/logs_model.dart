import '../../features/home/data/local_data_base/db_constants.dart';

// toDo
// create a method to retun a map of string int {'day name ':'the value'} to use it in chart view

class LogModel {
  final int? id;
  final int medicationId;
  String date;
  String? takenTime;
  String? status;
  String? nextTime;
  int? userId;

  // final int medId;
  LogModel({
    this.id,
    required this.medicationId,
    required this.date,
    this.takenTime,
    this.userId,
    this.nextTime,
    required this.status,
    // required this.medId,
  });

  Map<String, dynamic> toMap() {
    return {
      LogsTable.logId: id,
      MedsTable.medId: medicationId,
      LogsTable.logDateTime: date,
      LogsTable.logTakenTime: takenTime,
      LogsTable.logStatus: status,
      // MedsTable.mednextTime: nextTime
    };
  }

  factory LogModel.fromMap(Map<String, dynamic> map) {
    return LogModel(
      id: map[LogsTable.logId],
      medicationId: map[MedsTable.medId],
      date: map[LogsTable.logDateTime],
      takenTime: map[LogsTable.logTakenTime],
      status: map[LogsTable.logStatus],
      userId: map[UsersTable.userId],
      nextTime: map[MedsTable.mednextTime],
    );
  }

  @override
  toString() =>
      'LogModel(id: $id, medicationId: $medicationId, date: $date, takenTime: $takenTime, status: $status, nextTime: $nextTime )';

  Map<String, int> toBarCharData() {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return {names[DateTime.parse(date).weekday - 1]: 1};
  }

  String getWeekDay() {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return names[DateTime.parse(date).weekday - 1];
  }
}

mixin StatusValues {
  static const String pending = "pending";
  static const String taken = "taken";
  static const String missed = "missed";
  static const String skipped = "skipped";
}
