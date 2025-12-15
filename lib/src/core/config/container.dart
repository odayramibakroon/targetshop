import 'package:clone_whatsapp_round34/src/core/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

class GetItInit {
  static Future<void> setup() async {
    //! Core: register SharedPreferences first because other registrations depend on it
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => prefs);
    
    //! Localization
    getIt.registerLazySingleton<LanguageDataSource>(
        () => LanguageDataSource(getIt<SharedPreferences>()));
    getIt.registerFactory<LanguageCubit>(() => LanguageCubit(
        getIt<LanguageDataSource>(),
        Locale(getIt<LanguageDataSource>().getLanguage()),
    ));
  }
}