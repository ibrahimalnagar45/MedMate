import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Person? _currentUser;

  Future<Person?> getCurrentUser() async {
    emit(GetUserLoading());
    try {
      log('getting current user tiggered ');

      _currentUser = await Crud.instance.getCurrentUser();
      if (_currentUser != null) {
        emit(GetUserSuccess(_currentUser!));
      }
    } catch (e) {
      log('error in getting current user ${e.toString()}');
      emit(GetUserFailure(e.toString()));
    }
    return _currentUser;
  }

  Future<void> setCurrentUser(Person userModel) async {
    emit(SetUserLoading());
    try {
      await Crud.instance.setCurrentUser(userModel);
      
      emit(SetUserSuccess(userModel));
    } catch (e) {
      log('error in setting current user ${e.toString()}');
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
      setCurrentUser(newUser);
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
