part of 'logs_cubit.dart';

@immutable
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
