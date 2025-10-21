import 'package:flutter/material.dart';

import '../../../../../utils/text_styles.dart';
import '../../../data/models/onboarding_model.dart';

class OnBoardingViewWidget extends StatelessWidget {
  const OnBoardingViewWidget({super.key, required this.onboardingModel});
  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
          height: size.height * .5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(onboardingModel.image),
          ),
        ),
        // SizedBox(height: size.height * .02),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            onboardingModel.text,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyles.onBoardingTextStyle,
          ),
        ),
      ],
    );
  }
}
