import 'package:clone_whatsapp_round34/src/core/localization/language_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Simple Cubit that emits a [Locale].
class LanguageCubit extends Cubit<Locale> {
  final LanguageDataSource languageDataSource;

  /// The cubit no longer calls the get-usecase in the initializer.
  /// The initial locale is provided by the caller (DI container) to avoid
  /// analyzer warnings about fields used only in initializer lists.
  LanguageCubit(this.languageDataSource, Locale initial) : super(initial);

  void getLanguage() {
    final lang = languageDataSource.getLanguage();
    emit(Locale(lang));
  }
  Future<void> setLanguage(String lang) async {
    await languageDataSource.setLanguage(lang);
    emit(Locale(lang));
  }
}
