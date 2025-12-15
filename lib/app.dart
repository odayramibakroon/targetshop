import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:clone_whatsapp_round34/src/core/localization/localization.dart';
import 'package:clone_whatsapp_round34/src/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'src/core/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 914.3),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, ch) => DismissKeyboard(
        child: BlocProvider(
          create: (context) => getIt<LanguageCubit>(),
          child: BlocBuilder<LanguageCubit, Locale>(
            
            builder: (context, locale) => MaterialApp(
              title: 'WhatsApp Clone',
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: locale,
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.initial,
              onGenerateRoute: AppRoute.generate,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.system,
            ),
          ),
        ),
      ),
    );
  }
}
