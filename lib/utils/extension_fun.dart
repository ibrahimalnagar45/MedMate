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



  
}
