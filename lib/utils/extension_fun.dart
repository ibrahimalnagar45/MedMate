import 'package:flutter/material.dart';

extension Context on BuildContext {
  double height() {
    return MediaQuery.sizeOf(this).height;
  }

  double width() {
    return MediaQuery.sizeOf(this).width;
  }

  goTo(Widget widget) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => widget));
  }

  replaceWith(Widget widget) {
    Navigator.of(
      this,
    ).pushReplacement(MaterialPageRoute(builder: (context) => widget));
  }

  pop() {
    Navigator.of(this).pop();
  }

  // showSnackBar(String message) {
  //   ScaffoldMessenger.of(this).showSnackBar(SnackBar(
  //     content: Text(message),
  //     duration: const Duration(seconds: 2),
  //   ));
  // }

  // showErrorSnackBar(String message) {
  //   ScaffoldMessenger.of(this).showSnackBar(SnackBar(
  //     content: Text(message),
  //     duration: const Duration(seconds: 2),
  //     backgroundColor: Colors.red,
  //   ));
}

// }
