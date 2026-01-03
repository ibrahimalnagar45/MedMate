import 'dart:async';
import 'package:flutter/material.dart'; 
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/home/presentation/views/home_view.dart';
import 'package:midmate/utils/constants.dart';
import 'package:midmate/utils/extension_fun.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
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
  List<Person> users = [];
  Person? currentUser;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    timer = Timer.periodic(Duration(seconds: 2), (timer) => navigation());

    Future.sync(() async {
      currentUser = await getIt<UserRepository>().getCurrentUser();
    });

    getIt<UserRepository>().getAllusers().then((values) {
      users = values;
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFA7CDCC),
      body: SafeArea(
        child: Column(
          children: [
            CustomSkipIcon(currentUser: currentUser),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() => currentIndex = value);
                },
                itemCount: OnBoardingConstants.onBoardings(context).length,
                itemBuilder: (context, index) {
                  return OnBoardingViewWidget(
                    onboardingModel:
                        OnBoardingConstants.onBoardings(context)[index],
                  );
                },
              ),
            ),
            PageIndecator(
              length: OnBoardingConstants.onBoardings(context).length,
              currentIndex: currentIndex,
            ),
            SizedBox(height: size.height * .1),
            // const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  void navigation() {
    if (currentIndex < OnBoardingConstants.onBoardings(context).length - 1) {
      currentIndex++;
    } else if (currentIndex ==
        OnBoardingConstants.onBoardings(context).length - 1) {
      getIt<SharedPreferences>().setBool(
        SharedPrefrenceDb.onBoardingVisited,
        true,
      );

      if (users.isNotEmpty || currentUser == null) {
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
