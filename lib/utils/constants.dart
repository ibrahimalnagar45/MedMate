import 'package:flutter/material.dart';

import '../features/onboarding/data/models/onboarding_model.dart';
import 'image_controller.dart';

class OnBoardingConstants {
  OnBoardingConstants._();
  static List<OnboardingModel> onBoardings(BuildContext context) => [
    OnboardingModel(
      text: 'جدول وقم بإدارة أدويتك بسهولة باستخدام تقويم بسيط وسهل الاستخدام',
      image: ImageController.onBoardingImage1,
    ),
    OnboardingModel(
      text:
          'لا تنسى أدويتك مرة أخرى! احصل على تذكيرات في الوقت المحدد للبقاء على المسار الصحيح مع صحتك.',
      image: ImageController.onBoardingImage2,
    ),
    OnboardingModel(
      text:
          'تناول أدويتك في الوقت المحدد يساعدك على الشعور بأفضل حال. سنساعدك على البقاء ملتزمًا!',
      image: ImageController.onBoardingImage3,
    ),
  ];
}
