import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'src/core/config/config.dart';
import 'src/core/localization/language_cubit.dart';
import 'src/core/routes/routes.dart';
import 'src/core/theme/theme.dart';
import 'src/core/utils/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 914.3),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, ch) => DismissKeyboard(
        child: ChangeNotifierProvider(
          create: (_) => ThemeController()..loadTheme(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LanguageCubit>(
                create: (_) => getIt<LanguageCubit>()..getLanguage(), // ✅ مهم
              ),
            ],
            child: BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                final themeMode = context.watch<ThemeController>().themeMode;

                return MaterialApp(
                  title: 'Target Shop',
                  debugShowCheckedModeBanner: false,

                   localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  locale: locale,

                   localeResolutionCallback: (deviceLocale, supportedLocales) {
                    if (deviceLocale == null) return const Locale('en');
                    for (final supported in supportedLocales) {
                      if (supported.languageCode == deviceLocale.languageCode) {
                        return supported;
                      }
                    }
                    return const Locale('en');
                  },

                  // ✅ Theme
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeMode,

                  // ✅ Routes
                  initialRoute: RoutesName.initial,
                  onGenerateRoute: AppRoute.generate,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
