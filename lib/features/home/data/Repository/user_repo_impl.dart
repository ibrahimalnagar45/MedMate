import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/utils/models/user_model.dart';

class UserRepoImpl implements UserRepository {
  final Crud crud;

  UserRepoImpl({required this.crud});
  @override
  Future<List<Person>> getAllusers() async {
    var users = await crud.getAllusers();

    return users;
  }

  @override
  Future<Person?> getCurrentUser() async {
    var user = await crud.getCurrentUser();
    return user;
  }

  @override
  Future<void> insertUser(Person user) async {
    await crud.insertUser(user);
  }

  @override
  Future<bool> isUserExist(Person user) async {
    var isUserExist = await crud.doesUserExist(user);
    return isUserExist;
  }

  @override
  Future<void> setCurrentUser(Person user) async {
    await crud.setCurrentUser(user);
  }

  @override
  Future<void> updateUserInfo(UserModel user) async {
    await crud.updateUserInfo(user);
  }
}
