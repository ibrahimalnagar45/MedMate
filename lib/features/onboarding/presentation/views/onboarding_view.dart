import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:midmate/features/home/presentation/views/home_view.dart';
import 'package:midmate/utils/constants.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/app_colors.dart';
import '../../../user_data/presentation/views/user_data_view.dart';
import 'widgets/custom_skip_icon.dart';
import 'widgets/onboarding_widget.dart';
import 'widgets/page_indecator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late Timer timer;
  int currentIndex = 0;
  SharedPreferences prefs = getIt<SharedPreferences>();

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    timer = Timer.periodic(Duration(seconds: 2), (timer) => navigation());

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _pageController.dispose();
    log(
      'from onboardingview the value SharedPrefrenceDb.onBoardingVisited is ${prefs.getBool(SharedPrefrenceDb.onBoardingVisited)}',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.teal.withOpacity(.999),
      body: SafeArea(
        child: Column(
          children: [
            CustomSkipIcon(),
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() => currentIndex = value);
                },
                itemCount: Constants.onBoardings.length,
                itemBuilder: (context, index) {
                  return OnBoardingViewWidget(
                    onboardingModel: Constants.onBoardings[index],
                  );
                },
              ),
            ),
            PageIndecator(
              length: Constants.onBoardings.length,
              currentIndex: currentIndex,
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }

  navigation() {
    if (currentIndex < Constants.onBoardings.length - 1) {
      currentIndex++;
    } else if (currentIndex == Constants.onBoardings.length - 1) {
      getIt<SharedPreferences>().setBool(
        SharedPrefrenceDb.onBoardingVisited,
        true,
      );
      debugPrint(
        'from onboardingview the value SharedPrefrenceDb.onBoardingVisited is ${prefs.getBool(SharedPrefrenceDb.onBoardingVisited)}',
      );
      if (getIt<UserModel>().getUser().name == null) {
        context.replaceWith(UserDataView());
      } else {
        context.replaceWith(HomeView());
      }
      timer.cancel();
      // _pageController.dispose();
    } else {
      currentIndex--;
    }
    _pageController.animateToPage(
      currentIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
