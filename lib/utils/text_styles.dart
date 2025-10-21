import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextStyles {
  TextStyles._();

  static const TextStyle primaryBoldBlackTextStyle = TextStyle(
    // fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.w800,
    fontSize: 20,
  );

  static const TextStyle regGreyTextStyle = TextStyle(
    fontWeight: FontWeight.w400,

    color: AppColors.grey,
  );

  static const TextStyle regBlackTextStyle = TextStyle(
    // fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.w700,
    fontSize: 15,
    color: Colors.black,
  );
  static const TextStyle regWhtieTextStyle = TextStyle(
    // fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.w700,
    fontSize: 15,
    color: Colors.white,
  );

  static const TextStyle onBoardingTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle hintTextStyle = TextStyle(
    color: AppColors.blue,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
  );
}
