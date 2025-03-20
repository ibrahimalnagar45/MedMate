import 'package:flutter/material.dart';

import '../../../../../utils/text_styles.dart';
import '../../../data/models/onboarding_model.dart';

class OnBoardingViewWidget extends StatelessWidget {
  const OnBoardingViewWidget({super.key, required this.onboardingModel});
  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          child: Image.asset(onboardingModel.image),
          borderRadius: BorderRadius.circular(12),
        ),
        const SizedBox(height: 50),
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
