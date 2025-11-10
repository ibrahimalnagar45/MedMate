import '../../features/home/data/local_data_base/db_constants.dart';

int globalId = 20;

class Person {
  String? name;
  String? birthDayDate;
  int isCurrentUser;
  int? id;

  Person({this.name, this.birthDayDate, this.id, this.isCurrentUser = 0});

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map[UsersTable.userName],
      birthDayDate: map[UsersTable.userAge],
      isCurrentUser: map[UsersTable.isCurrentUser] as int,
      id: map[UsersTable.userId] as int,
    );
  }

Map<String,dynamic>  toMap() {
    return {
      UsersTable.isCurrentUser: isCurrentUser,
      // DbConstants.userId: id,
      UsersTable.userName: name,
      UsersTable.userAge: birthDayDate,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Person &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            id == other.id &&
            birthDayDate == other.birthDayDate;
  }

  @override
  int get hashCode => name.hashCode ^ birthDayDate.hashCode;

  @override
  String toString() {
    return 'UserModel{id: $id, isCurrentUser: $isCurrentUser, name: $name, age: $birthDayDate}';
  }
}

class UserModel extends Person {
  UserModel._();
  static UserModel instance = UserModel._();

  Person getUser() => Person(name: instance.name, birthDayDate: instance.birthDayDate);

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, age: $birthDayDate, isCurrentUser: $isCurrentUser}';
  }
}
