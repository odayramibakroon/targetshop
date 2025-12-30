 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'src/core/localization/language_cubit.dart';
import 'src/core/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/core/theme/theme.dart';
 import 'src/features/users/cubit/user_cubit.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 914.3),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, ch) => DismissKeyboard(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LanguageCubit>(
              create: (context) => getIt<LanguageCubit>(),
            ),
            BlocProvider<UserCubit>(
              create: (context) => getIt<UserCubit>()..loadUser(),  
            ),
          ],
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