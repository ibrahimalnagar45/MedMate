part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

final class GetUserLoading extends UserState {}

final class GetUserSuccess extends UserState {
  final Person user;
  GetUserSuccess(this.user);
}

final class GetUserFailure extends UserState {
  final String errorMessage;
  GetUserFailure(this.errorMessage);
}

final class SetUserLoading extends UserState {}

final class SetUserSuccess extends UserState {
  final Person user;
  SetUserSuccess(this.user);
}

final class SetUserFailure extends UserState {
  final String errorMessage;
  SetUserFailure(this.errorMessage);
}

final class GetAllUserLoading extends UserState {}

final class GetAllUserSuccess extends UserState {
  final List<Person> users;
  GetAllUserSuccess(this.users);
}

final class GetAllUserFailure extends UserState {
  final String errorMessage;
  GetAllUserFailure(this.errorMessage);
}

final class AddNewUserLoading extends UserState {}

final class AddNewUserSuccess extends UserState {
  final Person user;
  AddNewUserSuccess(this.user);
}

final class AddNewUserFailure extends UserState {
  final String errorMessage;
  AddNewUserFailure(this.errorMessage);
}
