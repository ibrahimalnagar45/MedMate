import '../../features/home/data/local_data_base/db_constants.dart';

int globalId = 20;

class Person {
  String? name;
  String? age;
  int? insertedId;
  int? id;

  Person({this.name, this.age, this.id, this.insertedId});

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map[DbConstants.usersColumnName],
      age: map[DbConstants.usersColumnAge],
      insertedId: map[DbConstants.usersColumnInsertedId] as int,
      id: map[DbConstants.usersColumnId] as int,
    );
  }

  toMap() {
    return {
      DbConstants.usersColumnInsertedId: insertedId,
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
    return 'UserModel{id: $id, insertedId: $insertedId, name: $name, age: $age}';
  }
}

class UserModel extends Person {
  UserModel._();
  static UserModel instance = UserModel._();

  Person getUser() => Person(name: instance.name, age: instance.age);

  @override
  String toString() {
    return 'UserModel{id: $id,insertedId: $insertedId, name: $name, age: $age}';
  }
}
