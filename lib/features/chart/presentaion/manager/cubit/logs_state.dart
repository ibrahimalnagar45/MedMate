part of 'logs_cubit.dart';

sealed class LogsState {}

final class LogsInitial extends LogsState {}

final class InserLogLoading extends LogsState {}

final class InsertLogFaluire extends LogsState {
  final String erMessage;
  InsertLogFaluire({required this.erMessage});
}

final class InsertLogSuccess extends LogsState {
  final LogModel log;
  InsertLogSuccess({required this.log});
}

final class GetUserLogsLoading extends LogsState {}

final class GetUserLogsSuccess extends LogsState {
  final List<LogModel> logs;
  GetUserLogsSuccess({required this.logs});
}

final class GetUserLogsFaluire extends LogsState {
  final String erMessage;
  GetUserLogsFaluire({required this.erMessage});
}

final class GetTodayLogsLoading extends LogsState {}

final class GetTodayLogsSuccess extends LogsState {
  final List<LogModel> logs;
  GetTodayLogsSuccess({required this.logs});
}

final class GetTodayLogsFaluire extends LogsState {
  final String erMessage;
  GetTodayLogsFaluire({required this.erMessage});
}

final class UpdateLogLoading extends LogsState {}

final class UpdateLogSuccess extends LogsState {
  final int flag;
  UpdateLogSuccess({required this.flag});
}

final class UpdateLogFaluire extends LogsState {
  final String errorMessage;

  UpdateLogFaluire({required this.errorMessage});
}
