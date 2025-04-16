import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:midmate/features/home/presentation/views/home_view.dart';
import 'package:midmate/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:midmate/features/user_data/presentation/views/user_data_view.dart';
 import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/image_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
//
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _initialized = false;
  // bool _toHome = false;
  bool onBoardingVisited =
      getIt<SharedPreferences>().getBool(SharedPrefrenceDb.onBoardingVisited) ??
      false;

  String? userName = getIt<SharedPreferences>().getString(
    SharedPrefrenceDb.username,
  );
  @override
  void initState() {
    super.initState();

    ensureInitialized();
    // Wait for Flutter to fully initialize
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      if (onBoardingVisited) {
        if (userName == null) {
          return UserDataView();
        }
        return HomeView();
      } else {
        return OnboardingView();
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          // height: 400,
          child: Lottie.asset(
            ImageController.splashLottieImage,
            animate: true,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            repeat: true,
            reverse: true,
          ),
        ),
      ),
    );
  }

  void ensureInitialized() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        Duration(seconds: 3),
      ); // Short delay for better transition
      setState(() {
        _initialized = true;
      });
    });
  }
}
