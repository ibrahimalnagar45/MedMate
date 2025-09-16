import '../../features/home/data/local_data_base/db_constants.dart';

int globalId = 20;

class Person {
  String? name;
  String? age;
  int isCurrentUser;
  int? id;

  Person({this.name, this.age, this.id, this.isCurrentUser = 0});

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map[DbConstants.usersColumnName],
      age: map[DbConstants.usersColumnAge],
      isCurrentUser: map[DbConstants.isCurrentUser] as int,
      id: map[DbConstants.usersColumnId] as int,
    );
  }

  toMap() {
    return {
      DbConstants.isCurrentUser: isCurrentUser,
      // DbConstants.usersColumnId: id,
      DbConstants.usersColumnName: name,
      DbConstants.usersColumnAge: age,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Person &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            id == other.id &&
            age == other.age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;

  @override
  String toString() {
    return 'UserModel{id: $id, isCurrentUser: $isCurrentUser, name: $name, age: $age}';
  }
}

class UserModel extends Person {
  UserModel._();
  static UserModel instance = UserModel._();

  Person getUser() => Person(name: instance.name, age: instance.age);

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, age: $age, isCurrentUser: $isCurrentUser}';
  }
}
