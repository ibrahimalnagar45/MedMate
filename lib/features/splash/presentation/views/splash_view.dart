import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/core/services/local_notification.dart';
import 'package:midmate/features/home/presentation/views/home_view.dart';
import 'package:midmate/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:midmate/features/user_data/presentation/views/user_data_view.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../main.dart';
import '../../../../utils/image_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  //
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _initialized = false;
  bool onBoardingVisited =
      getIt<SharedPreferences>().getBool(SharedPrefrenceDb.onBoardingVisited) ??
      false;

  @override
  void initState() {
    super.initState();
    // currentUser = BlocProvider.of<UserCubit>(context).getCurrentUser();
    ensureInitialized();
    // Wait for Flutter to fully initialize
  }

  @override
  void dispose() {
    LocalNotification(
      navigatorKey: navigatorKey,
    ).initializeDefaultNotificationSetting();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      if (onBoardingVisited) {
        if (getIt<UserCubit>().getCurrentUser() == null) {
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
            // 'assets/images/splash_screen.json'whs,
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
