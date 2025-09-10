import '../../features/home/data/local_data_base/db_constants.dart';

int globalId = 20;

class Person {
  String? name;
  String? age;
  int? id;

  Person({this.name, this.age, this.id});

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(name: map['name'], age: map['age'], id: map['userId']);
  }

  toMap() {
    return {DbConstants.usersColumnInsertedId: id, 'name': name, 'age': age};
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
    return 'UserModel{id: $id, name: $name, age: $age}';
  }
}

class UserModel extends Person {
  UserModel._();
  static UserModel instance = UserModel._();
 
  Person getUser() => Person(name: instance.name, age: instance.age);

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, age: $age}';
  }
}
