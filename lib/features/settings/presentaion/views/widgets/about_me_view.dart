import 'package:flutter/material.dart';
import 'package:midmate/utils/constants.dart';

import '../../../../../core/widgets/app_bar.dart';
import '../../../../../generated/l10n.dart';

class AboutMeView extends StatelessWidget {
 const  AboutMeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        screenName: S.current.TermsAndPolicySection,
        context: context,
        autoleading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            Localizations.localeOf(context).languageCode == 'en'
                ? AboutMe.aboutAppEn
                : AboutMe.aboutAppAr,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
