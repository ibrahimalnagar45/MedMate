import 'package:midmate/utils/models/user_model.dart';

abstract class UserRepository {
  Future<void> insertUser(Person user);
  Future<List<Person>> getAllusers();
  Future<void> setCurrentUser(Person user);
  Future<Person?> getCurrentUser();
  Future<bool> isUserExist(Person user);
  Future<void> updateUserInfo(UserModel user);
}
