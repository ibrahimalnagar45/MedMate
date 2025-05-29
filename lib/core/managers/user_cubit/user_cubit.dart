import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/services/shared_prefrence_service.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Person? _currentUser;

  Person? getCurrentUser() {
    emit(GetUserLoading());
    try {
      _currentUser = Person(
        name: getIt<SharedPreferences>().getString(SharedPrefrenceDb.username),
        age: getIt<SharedPreferences>().getString(SharedPrefrenceDb.userAge),
        id: int.tryParse(
          getIt<SharedPreferences>().getString(SharedPrefrenceDb.userId)!,
        ),
      );

      log('current user from cubit ');
      log(_currentUser.toString());
      emit(GetUserSuccess(_currentUser!));
    } catch (e) {
      emit(GetUserFailure(e.toString()));
    }
    return _currentUser;
  }

  void setCurrentUser(Person userModel) {
    emit(SetUserLoading());
    try {
      getIt<SharedPreferences>().setString(
        SharedPrefrenceDb.username,
        userModel.name!,
      );
      getIt<SharedPreferences>().setString(
        SharedPrefrenceDb.userAge,
        userModel.age!,
      );
      getIt<SharedPreferences>().setString(
        SharedPrefrenceDb.userId,
        userModel.id.toString(),
      );

      _currentUser = userModel;
      log('set the current user to ${_currentUser.toString()}');
      emit(SetUserSuccess(userModel));
    } catch (e) {
      emit(SetUserFailure(e.toString()));
    }
  }

  Future<void> addNewUser(Person user) async {
    emit(AddNewUserLoading());
    log('add new user called');
    try {
      if (await Crud.instance.doesUserExist(user)) {
        log('User already exists');
        emit(AddNewUserFailure('User already exists'));
        return;
      }
      Person newUser = await Crud.instance.insertUser(user);

      // setCurrentUser(newUser);
      emit(AddNewUserSuccess(newUser));
      log('New user added successfully: ${newUser.toString()}');
    } catch (e) {
      emit(AddNewUserFailure(e.toString()));
    }
  }

  Future<List<Person>> getAllUsers() async {
    List<Person> users = [];
    emit(GetAllUserLoading());
    try {
      users = await Crud.instance.getAllusers();
      log('all users');
      users.map((user) {
        log(' ${user.toString()}');
      }).toList();
      emit(GetAllUserSuccess(users));
    } catch (e) {
      emit(GetAllUserFailure(e.toString()));
    }

    return users;
  }
}
