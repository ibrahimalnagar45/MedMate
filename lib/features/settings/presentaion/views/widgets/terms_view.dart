import 'package:flutter/material.dart';
import 'package:midmate/core/widgets/app_bar.dart';

import '../../../../../generated/l10n.dart';

class TermView extends StatelessWidget {
  TermView({super.key});
  String englishTermsAndConditions = """
Terms & Conditions for RemindMe
Last updated: [${DateTime.now().toLocal().day}-${DateTime.now().toLocal().month}-${DateTime.now().toLocal().year}]

Welcome to RemindMe, a mobile application designed to help users schedule, track, and remember their medication times. By downloading, installing, or using RemindMe, you agree to be bound by these Terms & Conditions.

1. Acceptance of Terms
By accessing or using RemindMe, you confirm that you have read, understood, and agree to comply with these Terms. If you do not agree, you may not use the app.

2. App Purpose
RemindMe is intended to assist users by providing medication reminders and notifications. The app does not provide medical or professional healthcare advice, diagnosis, or treatment.

3. Eligibility
You must be at least 13 years old to use this app. If you are under 18, you must have permission from a parent or guardian.

4. User Responsibilities
By using RemindMe, you agree to:
- Enter accurate and up-to-date medication schedules.
- Use the app responsibly and in a lawful manner.
- Keep your device and app secure.
You are solely responsible for ensuring you take your medication as prescribed.

5. No Medical Guarantees
RemindMe provides reminder notifications only. We do not guarantee that notifications will always be delivered or that your device will always function properly. The app is a support tool, not a substitute for professional medical advice.

6. Accounts & Data
Some features may require storing data on your device or through cloud services if enabled. You are responsible for the confidentiality and accuracy of your information.

7. Prohibited Uses
You may not:
- Reverse engineer or modify the app.
- Use the app for illegal or unauthorized purposes.
- Attempt to disrupt or hack the app or its services.

8. Intellectual Property
All content in RemindMe—including logos, design, text, code, and features—is the property of the developer and protected by intellectual property laws. You may not copy, reproduce, or distribute the app without permission.

9. App Updates & Changes
We may update or modify the app at any time. Updated Terms may also be provided. Continued use of the app after updates means you accept the changes.

10. Third-Party Services
The app may use third-party tools or services such as notification APIs or cloud backups. We are not responsible for the actions or policies of third-party providers.

11. Limitation of Liability
To the fullest extent permitted by law:
- We are not liable for any direct, indirect, or incidental damages resulting from the use of RemindMe.
- We do not guarantee the delivery of reminders or error-free app performance.
- You use the app at your own risk.

12. Termination
We may restrict or terminate your access if you violate these Terms or if required by law. You may stop using the app at any time by uninstalling it.

13. Governing Law
These Terms are governed by the laws of Egypt (or your preferred jurisdiction). Any disputes will be handled according to applicable local laws.

14. Contact Information
For support or questions about these Terms:
Email: [ibrahimkamalalnagar@gmail.com]
Developer: Ibrahim El-Nagar

Thank you for using RemindMe.
""";
  String arabicTermsAndConditions = """
شروط وأحكام استخدام تطبيق RemindMe
آخر تحديث: [${DateTime.now().toLocal().day}-${DateTime.now().toLocal().month}-${DateTime.now().toLocal().year}]

مرحبًا بك في RemindMe، وهو تطبيق يساعد المستخدمين على جدولة الأدوية وتذكيرهم بمواعيد تناولها. باستخدامك للتطبيق فإنك توافق على الالتزام بهذه الشروط والأحكام. الرجاء قراءتها بعناية.

1. قبول الشروط
باستخدامك للتطبيق فإنك تؤكد أنك قرأت هذه الشروط وفهمتها وتوافق على الالتزام بها. إذا لم توافق على أي جزء من هذه الشروط فلا يجوز لك استخدام التطبيق.

2. هدف التطبيق
يهدف RemindMe إلى تقديم تذكيرات وتنبيهات لمواعيد تناول الدواء. التطبيق لا يقدم أي استشارات طبية أو تشخيص أو علاج طبي.

3. أهلية الاستخدام
يجب أن يكون عمرك 13 عامًا على الأقل لاستخدام التطبيق. إذا كان عمرك أقل من 18 عامًا فيجب الحصول على إذن من ولي الأمر.

4. مسؤوليات المستخدم
باستخدامك للتطبيق فإنك توافق على:
- إدخال بيانات صحيحة ومحدثة حول مواعيد الأدوية.
- استخدام التطبيق بطريقة مسؤولة وقانونية.
- الحفاظ على أمان جهازك وبياناتك.
أنت وحدك المسؤول عن الالتزام بمواعيد الدواء وعدم الاعتماد الكامل على التطبيق كبديل للتعليمات الطبية.

5. عدم وجود ضمانات طبية
يقدم RemindMe تذكيرات فقط ولا يضمن:
- وصول الإشعارات دائمًا.
- عمل جهازك أو اتصالك بشكل دائم.
التطبيق أداة مساعدة فقط ولا يغني عن استشارة الطبيب أو الالتزام بتعليماته.

6. الحسابات والبيانات
قد يتطلب التطبيق تخزين بعض البيانات على جهازك أو على خدمات سحابية عند تفعيلها. أنت المسؤول عن سرية هذه البيانات ودقتها.

7. الاستخدامات المحظورة
يمنع عليك:
- محاولة تعديل أو تفكيك أو عكس هندسة التطبيق.
- استخدام التطبيق لأي أغراض غير قانونية.
- محاولة تعطيل أو اختراق التطبيق أو خوادمه.

8. الملكية الفكرية
جميع محتويات التطبيق بما في ذلك التصميمات والشعارات والكود والميزات مملوكة للمطور ومحفوظة بموجب قوانين الملكية الفكرية. لا يجوز نسخ أو إعادة توزيع أي جزء من التطبيق دون إذن مسبق.

9. التحديثات والتغييرات
قد نقوم بتحديث التطبيق أو تعديل خصائصه في أي وقت. كما قد يتم تحديث هذه الشروط. استمرارك في استخدام التطبيق يعني موافقتك على الشروط المحدثة.

10. خدمات أطراف ثالثة
قد يعتمد التطبيق على خدمات خارجية مثل نظام الإشعارات أو النسخ الاحتياطي. لسنا مسؤولين عن سياسات أو أفعال مزودي الخدمات الخارجيين.

11. حدود المسؤولية
إلى أقصى حد يسمح به القانون:
- لا نتحمل أي مسؤولية عن أي أضرار مباشرة أو غير مباشرة ناتجة عن استخدام التطبيق.
- لا نضمن أن التذكيرات ستصل دائمًا أو أن التطبيق خالٍ من الأخطاء.
- استخدامك للتطبيق يقع على مسؤوليتك الشخصية.

12. إنهاء الاستخدام
يجوز لنا تعليق أو إنهاء وصولك للتطبيق في حال مخالفتك لهذه الشروط أو إذا تطلب القانون ذلك. ويمكنك إيقاف استخدام التطبيق في أي وقت عن طريق إزالته من جهازك.

13. القانون الحاكم
تخضع هذه الشروط لقوانين جمهورية مصر العربية أو أي ولاية قضائية تحددها. ويتم حل أي نزاعات وفق القوانين المحلية المعمول بها.

14. بيانات التواصل
لأي استفسار يتعلق بهذه الشروط يرجى التواصل عبر:
البريد الإلكتروني: [ضع البريد هنا]
المطور: إبراهيم النجار

شكرًا لاستخدامك تطبيق RemindMe.
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
                ? englishTermsAndConditions
                : arabicTermsAndConditions,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
