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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Very soon you will be able to connect with your friends and invite them to attend events together`
  String get verySoonWillBeAbleToConnecting {
    return Intl.message(
      'Very soon you will be able to connect with your friends and invite them to attend events together',
      name: 'verySoonWillBeAbleToConnecting',
      desc: '',
      args: [],
    );
  }

  /// `Events nearby`
  String get eventsNearby {
    return Intl.message(
      'Events nearby',
      name: 'eventsNearby',
      desc: '',
      args: [],
    );
  }

  /// `My events`
  String get myEvents {
    return Intl.message(
      'My events',
      name: 'myEvents',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Become an organiser`
  String get becomeAnOrganiser {
    return Intl.message(
      'Become an organiser',
      name: 'becomeAnOrganiser',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Are you want log out from your account?`
  String get areYouWantLogOutFromYourAccount {
    return Intl.message(
      'Are you want log out from your account?',
      name: 'areYouWantLogOutFromYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `City: {selectedCity}`
  String citySelectedcity(Object selectedCity) {
    return Intl.message(
      'City: $selectedCity',
      name: 'citySelectedcity',
      desc: '',
      args: [selectedCity],
    );
  }

  /// `Time: {selectedTimeFilter}`
  String timeSelectedtimefilter(Object selectedTimeFilter) {
    return Intl.message(
      'Time: $selectedTimeFilter',
      name: 'timeSelectedtimefilter',
      desc: '',
      args: [selectedTimeFilter],
    );
  }

  /// `Organiser name`
  String get organiserName {
    return Intl.message(
      'Organiser name',
      name: 'organiserName',
      desc: '',
      args: [],
    );
  }

  /// `Write the event name...`
  String get writeTheEventName {
    return Intl.message(
      'Write the event name...',
      name: 'writeTheEventName',
      desc: '',
      args: [],
    );
  }

  /// `Write the event city...`
  String get writeTheEventCity {
    return Intl.message(
      'Write the event city...',
      name: 'writeTheEventCity',
      desc: '',
      args: [],
    );
  }

  /// `Write the event location...`
  String get writeTheEventLocation {
    return Intl.message(
      'Write the event location...',
      name: 'writeTheEventLocation',
      desc: '',
      args: [],
    );
  }

  /// `Chose day and time when event start`
  String get choseDayAndTimeWhenEventStart {
    return Intl.message(
      'Chose day and time when event start',
      name: 'choseDayAndTimeWhenEventStart',
      desc: '',
      args: [],
    );
  }

  /// `Write the event description...`
  String get writeTheEventDescription {
    return Intl.message(
      'Write the event description...',
      name: 'writeTheEventDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add content`
  String get addContent {
    return Intl.message(
      'Add content',
      name: 'addContent',
      desc: '',
      args: [],
    );
  }

  /// `< your image will appear here if you add it`
  String get yourImageWillAppearHereIfYouAddIt {
    return Intl.message(
      '< your image will appear here if you add it',
      name: 'yourImageWillAppearHereIfYouAddIt',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all empty fields`
  String get pleaseFillInAllEmptyFields {
    return Intl.message(
      'Please fill in all empty fields',
      name: 'pleaseFillInAllEmptyFields',
      desc: '',
      args: [],
    );
  }

  /// `Save the event?`
  String get saveTheEvent {
    return Intl.message(
      'Save the event?',
      name: 'saveTheEvent',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Are you want delete this event from "My events"?`
  String get areYouWantDeleteThisEventFromMyEvents {
    return Intl.message(
      'Are you want delete this event from "My events"?',
      name: 'areYouWantDeleteThisEventFromMyEvents',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you want delete this event? The event will be deleted completely for all users`
  String get areYouWantDeleteThisEventTheEventWillBe {
    return Intl.message(
      'Are you want delete this event? The event will be deleted completely for all users',
      name: 'areYouWantDeleteThisEventTheEventWillBe',
      desc: '',
      args: [],
    );
  }

  /// `Created by me >`
  String get createdByMe {
    return Intl.message(
      'Created by me >',
      name: 'createdByMe',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any events scheduled yet. You can find them and add them here on the 'Events nearby' screen`
  String get youDontHaveAnyEventsScheduledYetYouCanFind {
    return Intl.message(
      'You don`t have any events scheduled yet. You can find them and add them here on the `Events nearby` screen',
      name: 'youDontHaveAnyEventsScheduledYetYouCanFind',
      desc: '',
      args: [],
    );
  }

  /// `Created by me: "{orgName}"`
  String createdByMeOrgname(Object orgName) {
    return Intl.message(
      'Created by me: "$orgName"',
      name: 'createdByMeOrgname',
      desc: '',
      args: [orgName],
    );
  }

  /// `Very soon you will be able to add your photo here`
  String get verySoonYouWillBeAbleToAddYourPhoto {
    return Intl.message(
      'Very soon you will be able to add your photo here',
      name: 'verySoonYouWillBeAbleToAddYourPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Security`
  String get privacySecurity {
    return Intl.message(
      'Privacy & Security',
      name: 'privacySecurity',
      desc: '',
      args: [],
    );
  }

  /// `Not register? Sign up now!`
  String get notRegisterSignUpNow {
    return Intl.message(
      'Not register? Sign up now!',
      name: 'notRegisterSignUpNow',
      desc: '',
      args: [],
    );
  }

  /// `Already sign up? Go to sign in!`
  String get alreadySignUpGoToSignIn {
    return Intl.message(
      'Already sign up? Go to sign in!',
      name: 'alreadySignUpGoToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter both email and password.`
  String get pleaseEnterBothEmailAndPassword {
    return Intl.message(
      'Please enter both email and password.',
      name: 'pleaseEnterBothEmailAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get enterYourName {
    return Intl.message(
      'Enter Your Name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your @username`
  String get enterYourUsername {
    return Intl.message(
      'Enter Your @username',
      name: 'enterYourUsername',
      desc: '',
      args: [],
    );
  }

  /// `Chose your city...`
  String get choseYourCity {
    return Intl.message(
      'Chose your city...',
      name: 'choseYourCity',
      desc: '',
      args: [],
    );
  }

  /// `Write the correctly confirm password`
  String get writeTheCorrectlyConfirmPassword {
    return Intl.message(
      'Write the correctly confirm password',
      name: 'writeTheCorrectlyConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Found a bug or want to tell us about your wishes?`
  String get foundABugOrWantToTellUsAboutYour {
    return Intl.message(
      'Found a bug or want to tell us about your wishes?',
      name: 'foundABugOrWantToTellUsAboutYour',
      desc: '',
      args: [],
    );
  }

  /// `Write to us in a way convenient for you, we will be glad to receive all messages, even criticism)`
  String get writeToUsInAWayConvenientForYouWe {
    return Intl.message(
      'Write to us in a way convenient for you, we will be glad to receive all messages, even criticism)',
      name: 'writeToUsInAWayConvenientForYouWe',
      desc: '',
      args: [],
    );
  }

  /// `The application is still in a test version, so the organiser rights are granted manually by the developer. If you are an organiser of public events or one of your activities is holding various kinds of events, you are most likely represented in social networks or have a website with official emails or phone numbers.`
  String get theApplicationIsStillInATestVersionSoThe {
    return Intl.message(
      'The application is still in a test version, so the organiser rights are granted manually by the developer. If you are an organiser of public events or one of your activities is holding various kinds of events, you are most likely represented in social networks or have a website with official emails or phone numbers.',
      name: 'theApplicationIsStillInATestVersionSoThe',
      desc: '',
      args: [],
    );
  }

  /// `There are 3 ways to become an organiser in the ProPer life app:`
  String get thereAre3WaysToBecomeAnOrganiserInThe {
    return Intl.message(
      'There are 3 ways to become an organiser in the ProPer life app:',
      name: 'thereAre3WaysToBecomeAnOrganiserInThe',
      desc: '',
      args: [],
    );
  }

  /// `1. Instagram. Just write to us from your official account.`
  String get InstagramJustWriteToUsFromYourOfficialAccount {
    return Intl.message(
      '1. Instagram. Just write to us from your official account.',
      name: 'InstagramJustWriteToUsFromYourOfficialAccount',
      desc: '',
      args: [],
    );
  }

  /// `2. Messenger. Write to us from your business phone number, which is easily found on your website or the Internet.`
  String get MessengerWriteToUsFromYourBusinessPhoneNumber {
    return Intl.message(
      '2. Messenger. Write to us from your business phone number, which is easily found on your website or the Internet.',
      name: 'MessengerWriteToUsFromYourBusinessPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `3. Mail. Write to us from your official mail indicated on your Internet resources.`
  String get MailWriteToUsFromYourOfficialMailIndicated {
    return Intl.message(
      '3. Mail. Write to us from your official mail indicated on your Internet resources.',
      name: 'MailWriteToUsFromYourOfficialMailIndicated',
      desc: '',
      args: [],
    );
  }

  /// `In the message, specify your @username specified during registration and the desired name of the organiser that you want to have in the application.`
  String get inTheMessageSpecifyYourUsernameSpecifiedDuringRegistrationAnd {
    return Intl.message(
      'In the message, specify your @username specified during registration and the desired name of the organiser that you want to have in the application.',
      name: 'inTheMessageSpecifyYourUsernameSpecifiedDuringRegistrationAnd',
      desc: '',
      args: [],
    );
  }

  /// `Click on the appropriate icon to follow the link and become an organiser in a convenient way.`
  String get clickOnTheAppropriateIconBelowToFollowTheLink {
    return Intl.message(
      'Click on the appropriate icon to follow the link and become an organiser in a convenient way.',
      name: 'clickOnTheAppropriateIconBelowToFollowTheLink',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk'),
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
