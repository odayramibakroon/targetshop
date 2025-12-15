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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to Instant WhatsApp`
  String get welcome_title {
    return Intl.message(
      'Welcome to Instant WhatsApp',
      name: 'welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Agree and Continue`
  String get welcome_btn {
    return Intl.message(
      'Agree and Continue',
      name: 'welcome_btn',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get login_title {
    return Intl.message(
      'Enter your phone number',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp will need to verify your number`
  String get login_subtitle {
    return Intl.message(
      'WhatsApp will need to verify your number',
      name: 'login_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `What's my number?`
  String get login_subtitle_link {
    return Intl.message(
      'What\'s my number?',
      name: 'login_subtitle_link',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get login_field_hint {
    return Intl.message(
      'Phone number',
      name: 'login_field_hint',
      desc: '',
      args: [],
    );
  }

  /// `Carrier charges may apply`
  String get login_charges_info {
    return Intl.message(
      'Carrier charges may apply',
      name: 'login_charges_info',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get btn_next {
    return Intl.message('Next', name: 'btn_next', desc: '', args: []);
  }

  /// `Processing...`
  String get btn_loading {
    return Intl.message(
      'Processing...',
      name: 'btn_loading',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search_label {
    return Intl.message('Search', name: 'search_label', desc: '', args: []);
  }

  /// `Start typing to search`
  String get search_hint {
    return Intl.message(
      'Start typing to search',
      name: 'search_hint',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't automatically verify your phone number. Please enter it manually.`
  String get error_auto_verify {
    return Intl.message(
      'We couldn\'t automatically verify your phone number. Please enter it manually.',
      name: 'error_auto_verify',
      desc: '',
      args: [],
    );
  }

  /// `Verification failed. Please try again.`
  String get error_verify_failed {
    return Intl.message(
      'Verification failed. Please try again.',
      name: 'error_verify_failed',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred. Please try again.`
  String get error_unknown {
    return Intl.message(
      'An unknown error occurred. Please try again.',
      name: 'error_unknown',
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
