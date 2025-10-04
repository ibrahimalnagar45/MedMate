import '../../features/home/data/local_data_base/db_constants.dart';

class LogsModel {
  final int? id;
  final int medicationId;
  final String date;
  String? takenTime;
  String? status;
  // final int medId;
  LogsModel({
    this.id,
    required this.medicationId,
    required this.date,
    this.takenTime,
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
    };
  }

  LogsModel.fromMap(Map<String, dynamic> map)
    : id = map[LogsTable.logId],
      medicationId = map[MedsTable.medId],
      date = map[LogsTable.logDateTime],
      takenTime = map[LogsTable.logTakenTime],
      status = map[LogsTable.logStatus];

  /*
    id INTEGER PRIMARY KEY AUTOINCREMENT,
  medication_id INTEGER NOT NULL,
  date TEXT NOT NULL,          -- YYYY-MM-DD
  taken_time TEXT,             -- actual time user confirmed
  status TEXT NOT NULL,        -- "taken", "missed", "skipped"
  FOREIGN KEY (medication_id) REFERENCES ${DbConstants.medTableName} (${DbConstants.medsColumnId})
         */
}

mixin StatusValues {
  static const String pending = "pending";
  static const String taken = "taken";
  static const String missed = "missed";
  static const String skipped = "skipped";
}
