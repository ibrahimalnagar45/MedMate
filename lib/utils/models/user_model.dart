import 'package:midmate/utils/models/med_model.dart';

class Person {
  String? name;
  String? age;
  // i have to add this list to manage every user's meds
  List<MedModel>? meds;
  int? id;

  Person({this.name, this.age, this.meds, this.id});

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(name: map['name'], age: map['age']);
  }
  toMap() {
    return {'name': name, 'age': age};
  }
}

class UserModel extends Person {
  UserModel._();
  static UserModel instance = UserModel._();

  // void editUser(Person user) {
  //   instance.name = user.name;
  //   instance.age = user.age;

  // }

  Person getUser() => Person(name: instance.name, age: instance.age);

  @override
  String toString() {
    return 'UserModel{name: $name, age: $age}';
  }
}
