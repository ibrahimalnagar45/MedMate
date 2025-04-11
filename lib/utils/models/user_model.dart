class Person {
  String? name;
  String? age;

  Person({this.name, this.age});
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
