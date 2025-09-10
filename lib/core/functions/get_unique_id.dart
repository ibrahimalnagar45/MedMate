import 'dart:math' as math;

import 'package:uuid/uuid.dart';

int getAUniqueId() {
  var uuid = Uuid().v4();
  int id =uuid.hashCode;
  return id;
}
