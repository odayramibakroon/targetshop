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
  String get posts {
    return Intl.message(
      'posts',
      name: 'posts',
      desc: '',
      args: [],
    );
  }
 String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }
   String get settings {
    return Intl.message(
      'settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }
  /// `Agree and Continue`
  String get favorites {
    return Intl.message(
      'favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get cart {
    return Intl.message(
      'cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp will need to verify your number`
  String get theme {
    return Intl.message(
      'theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `What's my number?`
  String get language {
    return Intl.message(
      'language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get language_hint {
    return Intl.message(
      'العربية/English',
      name: 'language_hint',
      desc: '',
      args: [],
    );
  }

  /// `Carrier charges may apply`
  String get change_password {
    return Intl.message(
      'change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }
  String get change_password_hint {
    return Intl.message(
      'Send password reset link',
      name: 'change_password_hint',
      desc: '',
      args: [],
    );
  }
 
 

  /// `Processing...`
  String get theme_hint {
    return Intl.message(
      'default/dark /light',
      name: 'theme_hint',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get exit {
    return Intl.message('exit', name: 'Exit', desc: '', args: []);
  }

  /// `Start typing to search`
  String get exit_hint {
    return Intl.message(
      'Sign out of the account',
      name: 'exit_hint',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't automatically verify your phone number. Please enter it manually.`
  String get error_auto_verify {
    return Intl.message(
      'theme',
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
