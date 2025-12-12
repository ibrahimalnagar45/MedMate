import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_bar.dart';
import '../../../../../generated/l10n.dart';

class AboutMeView extends StatelessWidget {
  AboutMeView({super.key});

  String aboutAppAr = """
عن تطبيق RemindMe

تطبيق RemindMe هو تطبيق مخصص لمساعدتك على تذكر مواعيد أدويتك. يقوم التطبيق بإرسال إشعارات في الوقت المحدد لكل جرعة حتى لا تفوت تناول أي دواء.

الميزات:
- سهولة إعداد تذكيرات الأدوية.
- إشعارات مخصصة لكل نوع دواء.
- واجهة بسيطة وسهلة الاستخدام.
- تتبع سجل الأدوية الخاص بك.

تطبيق RemindMe هو أداة مساعدة ولا يغني عن استشارة الطبيب. يرجى دائمًا اتباع تعليمات طبيبك.
""";
  String aboutAppEn = """
About RemindMe

RemindMe is a mobile application designed to help you remember your medication schedule. The app sends timely notifications for each dose so you never miss your medications. 

Features:
- Easy-to-set medication reminders.
- Custom notifications for different medications.
- Simple and user-friendly interface.
- Track your medication history.

RemindMe is a support tool and does not replace professional medical advice. Always follow your doctor's instructions.
""";

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
                ? aboutAppEn
                : aboutAppAr,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
