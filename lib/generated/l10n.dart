// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Schedule and manage your medications easily with a simple, easy-to-use calendar.`
  String get onBoardingText1 {
    return Intl.message(
      'Schedule and manage your medications easily with a simple, easy-to-use calendar.',
      name: 'onBoardingText1',
      desc: '',
      args: [],
    );
  }

  /// `Never forget your medications again! Get timely reminders to stay on track with your health.`
  String get onBoardingText2 {
    return Intl.message(
      'Never forget your medications again! Get timely reminders to stay on track with your health.',
      name: 'onBoardingText2',
      desc: '',
      args: [],
    );
  }

  /// `Taking your medications on time helps you feel your best. We’ll help you stay committed!`
  String get onBoardingText3 {
    return Intl.message(
      'Taking your medications on time helps you feel your best. We’ll help you stay committed!',
      name: 'onBoardingText3',
      desc: '',
      args: [],
    );
  }

  /// `Your Private Nurse`
  String get yourPrivateNurse {
    return Intl.message(
      'Your Private Nurse',
      name: 'yourPrivateNurse',
      desc: '',
      args: [],
    );
  }

  /// `Never forget your medicine again`
  String get dontForgetMedicine {
    return Intl.message(
      'Never forget your medicine again',
      name: 'dontForgetMedicine',
      desc: '',
      args: [],
    );
  }

  /// `{userName}`
  String userName(Object userName) {
    return Intl.message(
      '$userName',
      name: 'userName',
      desc: '',
      args: [userName],
    );
  }

  /// `Age`
  String get userAge {
    return Intl.message('Age', name: 'userAge', desc: '', args: []);
  }

  /// `You must enter your name`
  String get nameRequired {
    return Intl.message(
      'You must enter your name',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `{appBarTitle}`
  String appBarTitle(Object appBarTitle) {
    return Intl.message(
      '$appBarTitle',
      name: 'appBarTitle',
      desc: '',
      args: [appBarTitle],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `{medName}`
  String medName(Object medName) {
    return Intl.message('$medName', name: 'medName', desc: '', args: [medName]);
  }

  /// `{medDescription}`
  String medDescription(Object medDescription) {
    return Intl.message(
      '$medDescription',
      name: 'medDescription',
      desc: '',
      args: [medDescription],
    );
  }

  /// `{medType}`
  String medType(Object medType) {
    return Intl.message('$medType', name: 'medType', desc: '', args: [medType]);
  }

  /// `{dose}`
  String medDose(Object dose) {
    return Intl.message('$dose', name: 'medDose', desc: '', args: [dose]);
  }

  /// `{frequency}`
  String medFrequency(Object frequency) {
    return Intl.message(
      '$frequency',
      name: 'medFrequency',
      desc: '',
      args: [frequency],
    );
  }

  /// `{startDate}`
  String medStartDate(Object startDate) {
    return Intl.message(
      '$startDate',
      name: 'medStartDate',
      desc: '',
      args: [startDate],
    );
  }

  /// `{createdAt}`
  String medCreatedAt(Object createdAt) {
    return Intl.message(
      '$createdAt',
      name: 'medCreatedAt',
      desc: '',
      args: [createdAt],
    );
  }

  /// `{medNextTime}`
  String medNextTime(Object medNextTime) {
    return Intl.message(
      '$medNextTime',
      name: 'medNextTime',
      desc: '',
      args: [medNextTime],
    );
  }

  /// `Now`
  String get now {
    return Intl.message('Now', name: 'now', desc: '', args: []);
  }

  /// `Every`
  String get every {
    return Intl.message('Every', name: 'every', desc: '', args: []);
  }

  /// `Every Day`
  String get everyDay {
    return Intl.message('Every Day', name: 'everyDay', desc: '', args: []);
  }

  /// `Every 6 Hours`
  String get every6Hours {
    return Intl.message(
      'Every 6 Hours',
      name: 'every6Hours',
      desc: '',
      args: [],
    );
  }

  /// `Every 8 Hours`
  String get every8Hours {
    return Intl.message(
      'Every 8 Hours',
      name: 'every8Hours',
      desc: '',
      args: [],
    );
  }

  /// `Every 12 Hours`
  String get every12Hours {
    return Intl.message(
      'Every 12 Hours',
      name: 'every12Hours',
      desc: '',
      args: [],
    );
  }

  /// `Every {num} Hours`
  String everyNumHour(Object num) {
    return Intl.message(
      'Every $num Hours',
      name: 'everyNumHour',
      desc: '',
      args: [num],
    );
  }

  /// `Every {num} Hours`
  String everyNumHours(Object num) {
    return Intl.message(
      'Every $num Hours',
      name: 'everyNumHours',
      desc: '',
      args: [num],
    );
  }

  /// `After 6 Hours`
  String get after6Hours {
    return Intl.message(
      'After 6 Hours',
      name: 'after6Hours',
      desc: '',
      args: [],
    );
  }

  /// `After 8 Hours`
  String get after8Hours {
    return Intl.message(
      'After 8 Hours',
      name: 'after8Hours',
      desc: '',
      args: [],
    );
  }

  /// `After 12 Hours`
  String get after12Hours {
    return Intl.message(
      'After 12 Hours',
      name: 'after12Hours',
      desc: '',
      args: [],
    );
  }

  /// `After a Day`
  String get afterADay {
    return Intl.message('After a Day', name: 'afterADay', desc: '', args: []);
  }

  /// `ml`
  String get ml {
    return Intl.message('ml', name: 'ml', desc: '', args: []);
  }

  /// `medicine name`
  String get title {
    return Intl.message('medicine name', name: 'title', desc: '', args: []);
  }

  /// `description`
  String get description {
    return Intl.message('description', name: 'description', desc: '', args: []);
  }

  /// `No description`
  String get NoDescription {
    return Intl.message(
      'No description',
      name: 'NoDescription',
      desc: '',
      args: [],
    );
  }

  /// `type`
  String get type {
    return Intl.message('type', name: 'type', desc: '', args: []);
  }

  /// `dose`
  String get dose {
    return Intl.message('dose', name: 'dose', desc: '', args: []);
  }

  /// `frequency`
  String get frequency {
    return Intl.message('frequency', name: 'frequency', desc: '', args: []);
  }

  /// `start date`
  String get startDate {
    return Intl.message('start date', name: 'startDate', desc: '', args: []);
  }

  /// `next dose at`
  String get nextDoseAt {
    return Intl.message('next dose at', name: 'nextDoseAt', desc: '', args: []);
  }

  /// `unspecified`
  String get unSpecified {
    return Intl.message('unspecified', name: 'unSpecified', desc: '', args: []);
  }

  /// `example`
  String get example {
    return Intl.message('example', name: 'example', desc: '', args: []);
  }

  /// `Metformin`
  String get medNameExample {
    return Intl.message(
      'Metformin',
      name: 'medNameExample',
      desc: '',
      args: [],
    );
  }

  /// `Shake before use`
  String get medDescriptionExample {
    return Intl.message(
      'Shake before use',
      name: 'medDescriptionExample',
      desc: '',
      args: [],
    );
  }

  /// `Add Medicine`
  String get AddMedicine {
    return Intl.message(
      'Add Medicine',
      name: 'AddMedicine',
      desc: '',
      args: [],
    );
  }

  /// `pill`
  String get pill {
    return Intl.message('pill', name: 'pill', desc: '', args: []);
  }

  /// `powder`
  String get powder {
    return Intl.message('powder', name: 'powder', desc: '', args: []);
  }

  /// `syrup`
  String get syrup {
    return Intl.message('syrup', name: 'syrup', desc: '', args: []);
  }

  /// `drop`
  String get drop {
    return Intl.message('drop', name: 'drop', desc: '', args: []);
  }

  /// `cream`
  String get cream {
    return Intl.message('cream', name: 'cream', desc: '', args: []);
  }

  /// `injection`
  String get injection {
    return Intl.message('injection', name: 'injection', desc: '', args: []);
  }

  /// `inhaler`
  String get inhaler {
    return Intl.message('inhaler', name: 'inhaler', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
